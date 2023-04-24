//%attributes = {}
// queryTransactionByFilter (filterObj; dateRangeObj; inSimulator ; connecte): new obj
// This method is the optimized version of the query that is in getTransactionStats
// modified by Barclay to do only 1 query instead of multiple queries
// #ORDA
// #Aggregate sums


C_OBJECT:C1216($filterObj; $1; $dateRangeObj; $2)
C_BOOLEAN:C305($inSimulator; $3)
C_BOOLEAN:C305($connected; $4)

C_OBJECT:C1216($stats)
C_REAL:C285($sumVolume; $sumVolumeCash; $volumeLimit)
C_LONGINT:C283($relationType)
C_DATE:C307($fromDate; $toDate)
C_TEXT:C284($queryString; $query)
C_COLLECTION:C1488($queryCol; $queryFilter)

C_OBJECT:C1216($es; $0; $esEFT; $esCash)


Case of 
	: (Count parameters:C259=0)
		//$filterObj:= newFilterObj
		$filterObj:=agg_newFilterFromForm("ibcus1000583"; "")
		$dateRangeObj:=newDateRange(!00-00-00!; Current date:C33)
		$inSimulator:=False:C215
		
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


$queryString:=""
$queryFilter:=New collection:C1472
$queryCol:=New collection:C1472


$relationType:=$filterObj.relationType
If ($relationType#0)  // as long as the relationType is not zero, it means we are looking for connected transactions (transactions made by relatives)
	$connected:=True:C214
Else 
	// this when relationType = 0 in which case we don't we will only do connected transactions when the 4th parameter is set to true
End if 

If ($filterObj.days#0)
	C_DATE:C307($date)
	$date:=Date:C102($dateRangeObj.fromDate)  // this should be based on the date of the transaction (or invoice) not the current date #change
	$fromDate:=Add to date:C393($date; 0; 0; -$filterObj.days+1)
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


// @ibb moved this to first query b/c most rules will be on the invoice
// search in one Invoice may have to move higher in this search
If (($filterObj.invoiceID#"") & ($filterObj.isByInvoice=1))
	// I think we must do a search on the entity selection not on Registers
	// otherwise it doesn't make sense to do the queries above as this line
	// will overwrite anyways
	
	$queryFilter.push($filterObj.invoiceID)
	$queryCol.push("InvoiceNumber == :"+String:C10($queryFilter.length))
End if 

If ($filterObj.branchID#"")  // there is a filter on a branch
	$queryFilter.push($filterObj.branchID)
	$queryCol.push("BranchID == :"+String:C10($queryFilter.length))
	
	//$es:=$es.query("BranchID = :1"; $filterObj.branchID)
	// [Registers]BranchID
End if 

If ($filterObj.isCash#0)
	
	If (getKeyValue("cab"; "false")="true")  // settings that are specific to CAB
		// query the type of register for cash transaction only
		If ($filterObj.isCash=1)  // cash only
			$queryFilter.push(True:C214)
			//$es:=$es.query("isCash == true")  // cash only
		Else   // not cash
			$queryFilter.push(False:C215)
			//$es:=$es.query("isCash == false")  // non-cash
		End if 
		$queryCol.push("isCash == :"+String:C10($queryFilter.length))
		
		If ($filterObj.isEFT#0)
			$queryFilter.push("EFT")
			If ($filterObj.isEFT=1)  // EFT only
				$queryCol.push("RegisterType == :"+String:C10($queryFilter.length))
				//$es:=$es.query("RegisterType == 'EFT'")  // EFT only
			Else   // not cash
				$queryCol.push("RegisterType != :"+String:C10($queryFilter.length))
				//$es:=$es.query("RegisterType != 'EFT'")  // non-EFT
			End if 
		End if 
		
		// query the type of account for cash accounts only
	Else 
		If ($filterObj.isCash=1)  // cash only
			$queryFilter.push(True:C214)
			//$es:=$es.query("relatedAccount.isCashAccount == true")  // cash only
		Else   // not cash
			$queryFilter.push(False:C215)
			//$es:=$es.query("relatedAccount.isCashAccount == false")  // non-cash
		End if 
		$queryCol.push("relatedAccount.isCashAccount == :"+String:C10($queryFilter.length))
		
		If ($filterObj.isEFT#0)
			If ($filterObj.isEFT=1)  // cash only
				$queryFilter.push(True:C214)
				//$es:=$es.query("relatedAccount.isEFT = true")  // EFT only
			Else   // not cash
				$queryFilter.push(False:C215)
				//$es:=$es.query("relatedAccount.isEFT = false")  // non-EFT
			End if 
			$queryCol.push("relatedAccount.isEFT == :"+String:C10($queryFilter.length))
			
		End if 
		
	End if 
	
End if 

If (($filterObj.isByInvoice=0) & (($filterObj.days#0) | ($dateRangeObj.applyDateRange)))  // when the apply date range is on, or when there is a number of days to go back
	$queryFilter.push($fromDate)
	$queryFilter.push($toDate)
	$queryCol.push("RegisterDate >= :"+String:C10($queryFilter.length-1)+" AND RegisterDate <= :"+String:C10($queryFilter.length))
	
	//$es:=$es.query("RegisterDate >= :1 AND RegisterDate <= :2"; $fromDate; $toDate)  // query selection in ORDA
End if 

If ($filterObj.currency#"")  // if the currency is filtered
	$queryFilter.push($filterObj.currency)
	$queryCol.push("Currency == :"+String:C10($queryFilter.length))
	//$es:=$es.query("Currency = :1"; $filterObj.currency)
End if 

If ($filterObj.accountID#"")
	$queryFilter.push($filterObj.accountID)
	$queryCol.push("AccountID == :"+String:C10($queryFilter.length))
	//$es:=$es.query("AccountID = :1"; $filterObj.accountID)
End if 

If ($filterObj.direction#0)  // if an option was picked
	If ($filterObj.direction=1)  // Received
		$queryFilter.push(True:C214)
		//$es:=$es.query("isReceived = true")
	Else   // paid
		$queryFilter.push(False:C215)
		//$es:=$es.query("isReceived = false")
	End if 
	$queryCol.push("isReceived == :"+String:C10($queryFilter.length))
End if 

If ($filterObj.customerID#"")  // search by CustomerID ///
	If ($connected=False:C215)
		$queryFilter.push($filterObj.customerID)
		$queryCol.push("CustomerID == :"+String:C10($queryFilter.length))
	End if 
End if 

If ($filterObj.group#"")  // search by Customer Group // this function overrides the above search // #PotentialBUG #issue #test
	$queryFilter.push($filterObj.group)
	$queryCol.push("customer.GroupName == :"+String:C10($queryFilter.length))
	//$es:=$es.query("customer.GroupName = :1"; $filterObj.group)  // an extra filter on group
End if 



//------ EXECUTE QUERY -----
For each ($query; $queryCol)
	If ($queryString="")
		$queryString:=$query
	Else 
		$queryString:=$queryString+" AND "+$query
	End if 
End for each 

$es:=ds:C1482.Registers.query($queryString; New object:C1471("parameters"; $queryFilter))




If (($filterObj.customerID="") & ($filterObj.group=""))
Else 
	
	If ($filterObj.customerID#"")  // search by CustomerID /// ---- MIGHT NEED TO MAKE THIS THE LAST QUERY
		If ($connected)
			C_OBJECT:C1216($relatives)  //[Relations]relationType
			$relatives:=ds:C1482.Relations.query("customerID = :1 OR toCustomerID = :2"; $filterObj.customerID; $filterObj.customerID)  // find relatives of Customer A regardless of relationType and two ways  (either A ---> B or B---> A)
			
			If (($relationType>0) & ($relatives.length>0))  // if we found some relatives look for the particular relationType; if relationType is positive then look for all relatives between the parties (don't filter)
				$relatives:=$relatives.query("relationType= :1"; $relationType)
			End if 
			
			If ($relatives.length=0)  // if no relations were found then treat the entity selection normally and look for the customer ID
				//$queryFilter.push($filterObj.customerID)  // <---------  THIS MIGHT BE DUPLICATED
				//$queryCol.push("CustomerID == :"+String($queryFilter.length))
				
				// ---------  DO WE NEED THIS HERE
				$es:=$es.query("CustomerID = :1"; $filterObj.customerID)
			Else 
				// if there were some connections matching the relationType for that customer, the reflect it back to the customers and
				// get back all the registers belonging to those relations
				
				// ----- MAYBE THIS IS THE LAST THING TO RUN ??? -------
				$es:=$relatives.customer.or($relatives.toCustomer).registers  // find all registers related to customer or its relatives
			End if 
			
		End if 
	End if 
End if 



$0:=$es



If (False:C215)  // stats calc'd in parent method... DELETE THIS LATER
	If ($es#Null:C1517)
		If ($inSimulator)
			USE ENTITY SELECTION:C1513($es)  // no need to actually do a query unless in the simulator; this will affect the selection-based listbox on page 2: #TB
		End if 
		//[Registers]CreditLocal
		//[Registers]isCash
		$stats:=New object:C1471
		
		$stats.totalCount:=$es.length  // total number of registers (transactions)
		$stats.invoicesCount:=$es.distinct("InvoiceNumber").length  // total number of invoices
		$stats.branchesCount:=$es.distinct("BranchID").length
		$stats.currencies:=$es.distinct("Currency")  // collection of currencies
		$stats.currenciesCount:=$stats.currencies.length
		
		$stats.sumDebit:=$es.sum("Debit")
		$stats.sumCredit:=$es.sum("Credit")
		
		$stats.volumeBuy:=$es.sum("DebitLocal")
		$stats.volumeSell:=$es.sum("CreditLocal")
		
		$stats.sumGains:=$es.sum("UnrealizedGain")
		//[Accounts]isCashAccount
		//[Accounts]isCashAccount
		
		If (getKeyValue("CAB"; "false")="true")
			$esCash:=$es.query("isCash = true")
		Else 
			$esCash:=$es.query("relatedAccount.isCashAccount = true")
		End if 
		
		$stats.cashIn:=$esCash.sum("DebitLocal")
		$stats.cashOut:=$esCash.sum("CreditLocal")
		$stats.cashCount:=$esCash.length  // total number of Cash Transactions
		//[Registers]AccountID
		
		If (getKeyValue("CAB"; "false")="true")
			$esEFT:=$es.query("RegisterType = 'EFT'")
		Else 
			$esEFT:=$es.query("relatedAccount.isEFT = true")
		End if 
		$stats.EFTI:=$esEFT.sum("DebitLocal")
		$stats.EFTO:=$esEFT.sum("CreditLocal")
		$stats.EFTcount:=$esEFT.length  // total number of EFTs
		
		If (True:C214)
			If ($filterObj.purposeOfTransactions.length>0)
				$stats.POTs:=$es.query("metaData.purposeOfTransaction IN :1"; $filterObj.purposeOfTransactions).distinct("metaData.purposeOfTransaction")  //<--- OPTIMIZE ???
				If ($stats.POTs=Null:C1517)
					$stats.POTsCount:=0
				Else 
					$stats.POTsCount:=$stats.POTs.length
				End if 
			End if 
			
			If ($filterObj.sourceOfFunds.length>0)
				$stats.SOFs:=$es.query("metaData.sourceOfFund IN :1"; $filterObj.sourceOfFunds).distinct("metaData.sourceOfFund")
				If ($stats.sofs=Null:C1517)
					$stats.SOFsCount:=0
				Else 
					$stats.SOFsCount:=$stats.SOFs.length
				End if 
			End if 
			
			If ($filterObj.typeOfTransactions.length>0)
				$stats.TOTs:=$es.query("metaData.typeOfTransaction IN :1"; $filterObj.typeOfTransactions).distinct("metaData.typeOfTransaction")
				If ($stats.TOTs=Null:C1517)
					$stats.TOTsCount:=0
				Else 
					$stats.TOTsCount:=$stats.TOTs.length
				End if 
			End if 
			
			
		End if 
		
		//myAlert ("Transaction Volume = "+String(JSON Stringify($stats)))
		$0:=$stats  // return the stats
	End if 
End if 