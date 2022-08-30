//%attributes = {}
// getTransactionStats (filterObj; dateRangeObj; inSimulator ; connecte): new obj
// returns an object containing sums of different transaction value (like a stat object)
// NOTE: You DON'T need to create a New Object before calling this method, it creates a new object and returns the reference
// #ORDA
// #Aggregate sums


C_OBJECT:C1216($filterObj; $1; $dateRangeObj; $2)
C_BOOLEAN:C305($inSimulator; $3)
C_BOOLEAN:C305($connected; $4)

C_OBJECT:C1216($stats)
C_REAL:C285($sumVolume; $sumVolumeCash; $volumeLimit)
C_LONGINT:C283($relationType)
C_DATE:C307($fromDate; $toDate)

$volumeLimit:=10
C_OBJECT:C1216($es; $0; $esEFT; $esCash)
$connected:=False:C215

Case of 
	: (Count parameters:C259=1)  // 
		$filterObj:=$1
		$dateRangeObj:=newDateRange(Current date:C33)
		$inSimulator:=True:C214
		
	: (Count parameters:C259=2)  // 
		$filterObj:=$1
		$dateRangeObj:=$2
		$inSimulator:=True:C214
		
	: (Count parameters:C259=3)  // 
		$filterObj:=$1
		$dateRangeObj:=$2
		$inSimulator:=$3
		
	: (Count parameters:C259=4)  // 
		$filterObj:=$1
		$dateRangeObj:=$2
		$inSimulator:=$3
		$connected:=$4  // force to query connected transactions
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$relationType:=$filterObj.relationType
If ($relationType#0)  // as long as the relationType is not zero, it means we are looking for connected transactions (transactions made by relatives)
	$connected:=True:C214
Else 
	// this when relationType = 0 in which case we don't we will only do connected transactions when the 4th parameter is set to true 
End if 

If ($filterObj.days#0)
	C_DATE:C307($date)
	$date:=Date:C102($dateRangeObj.fromDate)  // this should be based on the date of the transaction (or invoice) not the current date #change
	$fromDate:=Add to date:C393($date; 0; 0; -$filterObj.days)
	$toDate:=Date:C102($dateRangeObj.toDate)
	
Else   // we should not have both a date range and # of days
	// @tiran : added the else so that we are not overwriting the fromDate and toDate in the following if
	// @tiran : changed this on Oct 11/ 2020 
	// getBuild
	
	If ($dateRangeObj.applyDateRange)
		$fromDate:=$dateRangeObj.fromDate
		$toDate:=$dateRangeObj.toDate
	End if 
End if 



If (($filterObj.customerID="") & ($filterObj.group=""))
	$es:=ds:C1482.Registers.all()
Else 
	
	If ($filterObj.customerID#"")  // search by CustomerID
		If ($connected=False:C215)
			$es:=ds:C1482.Registers.query("CustomerID = :1"; $filterObj.customerID)
		Else 
			C_OBJECT:C1216($relatives)
			//[Relations]relationType
			//[Relations]
			$relatives:=ds:C1482.Relations.query("customerID = :1 OR toCustomerID = :2"; $filterObj.customerID; $filterObj.customerID)  // find relatives of Customer A regardless of relationType and two ways  (either A ---> B or B---> A) 
			
			If (($relationType>0) & ($relatives.length>0))  // if we found some relatives look for the particular relationType; if relationType is positive then look for all relatives between the parties (don't filter)
				$relatives:=$relatives.query("relationType= :1"; $relationType)
			End if 
			
			If ($relatives.length=0)  // if no relations were found then treat the entity selection normally and look for the customer ID
				$es:=ds:C1482.Registers.query("CustomerID = :1"; $filterObj.customerID)
			Else 
				// if there were some connections matching the relationType for that customer, the reflect it back to the customers and 
				// get back all the registers belonging to those relations
				$es:=$relatives.customer.or($relatives.toCustomer).registers  // find all registers related to customer or its relatives
			End if 
			
		End if 
	End if 
	
	If ($filterObj.group#"")  // search by Customer Group // this function overrides the above search // #PotentialBUG #issue #test 
		//[registers]
		If ($es.length>0)  // we have already found some registers
			$es:=$es.query("customer.GroupName = :1"; $filterObj.group)  // an extra filter on group
		Else 
			$es:=ds:C1482.Registers.query("customer.GroupName = :1"; $filterObj.group)  // start the group filter
		End if 
	End if 
	
End if 

// search in one Invoice may have to move higher in this search
If (($filterObj.invoiceID#"") & ($filterObj.isByInvoice=1))
	C_TEXT:C284($fieldName)
	$fieldName:=Field name:C257(->[Registers:10]InvoiceNumber:10)
	$es:=ds:C1482.Registers.query($fieldName+" = :1"; $filterObj.invoiceID)
	
End if 

If ($filterObj.branchID#"")  // there is a filter on a branch
	$es:=$es.query("BranchID = :1"; $filterObj.branchID)
	// [Registers]BranchID
End if 

// [registers]
If ($filterObj.isCash#0)
	If ($filterObj.isCash=1)  // cash only
		$es:=$es.query("relatedAccount.isCashAccount = true")  // cash only
	Else   // not cash
		$es:=$es.query("relatedAccount.isCashAccount = false")  // non-cash
	End if 
End if 

If ($filterObj.isEFT#0)
	If ($filterObj.isEFT=1)  // cash only
		$es:=$es.query("relatedAccount.isEFT = true")  // EFT only
	Else   // not cash
		$es:=$es.query("relatedAccount.isEFT = false")  // non-EFT
	End if 
End if 


If (($filterObj.isByInvoice=0) & (($filterObj.days#0) | ($dateRangeObj.applyDateRange)))  // when the apply date range is on, or when there is a number of days to go back 
	$es:=$es.query("RegisterDate >= :1 AND RegisterDate <= :2"; $fromDate; $toDate)  // query selection in ORDA
End if 

If ($filterObj.currency#"")  // if the currency is filtered
	$es:=$es.query("Currency = :1"; $filterObj.currency)
End if 

If ($filterObj.accountID#"")
	$es:=$es.query("AccountID = :1"; $filterObj.accountID)
End if 


If ($filterObj.direction#0)  // if an option was picked
	If ($filterObj.direction=1)  // Received
		$es:=$es.query("isReceived = true")
	Else   // paid
		$es:=$es.query("isReceived = false")
	End if 
End if 

If ($es#Null:C1517)
	If ($inSimulator)
		USE ENTITY SELECTION:C1513($es)  // no need to actually do a query unless in the simulator; this will affect the selection-based listbox on page 2: #TB
	End if 
	//[Registers]CreditLocal
	//[Registers]isCash
	$stats:=New object:C1471
	$stats.totalCount:=$es.length  // total number of transactions
	$stats.countInvoices:=$es.invoice.length  // total number of invoices
	//[Registers]InvoiceNumber
	
	$stats.sumDebit:=$es.sum("Debit")
	$stats.sumCredit:=$es.sum("Credit")
	
	$stats.volumeBuy:=$es.sum("DebitLocal")
	$stats.volumeSell:=$es.sum("CreditLocal")
	
	$stats.sumGains:=$es.sum("UnrealizedGain")
	
	//[Accounts]isCashAccount
	//[Accounts]isCashAccount
	$esCash:=$es.query("relatedAccount.isCashAccount = true")
	$stats.cashIn:=$esCash.sum("DebitLocal")
	$stats.cashOut:=$esCash.sum("CreditLocal")
	$stats.countCash:=$esCash.length  // total number of Cash Transactions
	//[Registers]AccountID
	$esEFT:=$es.query("relatedAccount.isEFT = true")
	$stats.EFTI:=$esEFT.sum("DebitLocal")
	$stats.EFTO:=$esEFT.sum("CreditLocal")
	$stats.countEFT:=$esEFT.length  // total number of EFTs
	
	//myAlert ("Transaction Volume = "+String(JSON Stringify($stats)))
	$0:=$stats  // return the stats
End if 