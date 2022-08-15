//%attributes = {}

// Jonna
// Check_CustomersTop100 ($1) -> register table entity selection
// changed by Tiran to filter local currency amounts and exclude companies in the search
// also counting the number of invoices instead of registers



C_POINTER:C301($1; $listboxPtr)
C_POINTER:C301($2; $arrCustomerFullNamePtr; $3; $arrDatePeriodPtr)
C_POINTER:C301($4; $arrTransactionTypePtr; $5; $arrTotalTransPtr)
C_POINTER:C301($6; $arrTransCountPtr; $7; $arrNationalityPtr; $8; $arrIDNumberPtr)
ASSERT:C1129(Count parameters:C259=8; "Expected 8 parameters")


$listboxPtr:=$1
$arrCustomerFullNamePtr:=$2
$arrDatePeriodPtr:=$3
$arrTransactionTypePtr:=$4
$arrTotalTransPtr:=$5
$arrTransCountPtr:=$6
$arrNationalityPtr:=$7
$arrIDNumberPtr:=$8

C_OBJECT:C1216($registers)
$registers:=Create entity selection:C1512([Registers:10])

If ($registers.length>0)
	C_COLLECTION:C1488(cCustomerID)
	C_TEXT:C284($tCustomerID)
	C_LONGINT:C283($progress; $icount)
	C_COLLECTION:C1488(cCustomers)
	C_OBJECT:C1216($oCustomerTotal; $customer; $customerSelection)
	C_BOOLEAN:C305($isLoopStopped)
	
	cCustomers:=New collection:C1472
	cCustomerID:=$registers.distinct("CustomerID")
	// progress
	progressBarHandlingTemplate
	$progress:=launchProgressBar("Checking Top 100 Customer")
	
	For each ($tCustomerID; cCustomerID) Until (isProgressBarStopped($progress))
		
		$customer:=ds:C1482.Customers.query("CustomerID =:1 AND isCompany=false"; $tCustomerID).first()
		If ($customer#Null:C1517)
			If ($customer.isWalkin) | ($customer.isInsider)
				// ignore walkin and insider
			Else 
				$customerSelection:=$registers.query("CustomerID =:1 AND Currency != :2 AND customer.isCompany=false"; $tCustomerID; <>baseCurrency)
				If ($customerSelection.length>0)
					$oCustomerTotal:=New object:C1471
					$oCustomerTotal.customerID:=$customer.CustomerID
					$oCustomerTotal.customerName:=$customer.FullName
					$oCustomerTotal.datePeriod:=String:C10(vFromDate)+" to "+String:C10(vToDate)
					If ($customer.isCompany)
						$oCustomerTotal.transactionType:="Corporate"
					Else 
						$oCustomerTotal.transactionType:="Individuals"
					End if 
					$oCustomerTotal.totalTrans:=$customerSelection.sum("DebitLocal")+$customerSelection.sum("CreditLocal")
					$oCustomerTotal.transCount:=$customerSelection.count("InvoiceNumber")
					$oCustomerTotal.nationality:=$customer.Nationality
					$oCustomerTotal.idNumber:=$customer.PictureID_Number
					cCustomers.push($oCustomerTotal)
					$icount:=$icount+1
					
					If ($icount%5=1)
						refreshProgressBar($progress; $icount; cCustomerID.length)
						setProgressBarTitle($progress; "Customer "+$tCustomerID)
					End if 
				End if 
				
			End if 
		End if 
		
		$isLoopStopped:=isProgressBarStopped($progress)
		
	End for each 
	HIDE PROCESS:C324($progress)
	cCustomers:=cCustomers.orderBy("totalTrans desc")
	cCustomers:=cCustomers.slice(0; 100)
	
	COLLECTION TO ARRAY:C1562(cCustomers; $arrCustomerFullNamePtr->; "customerName"; $arrDatePeriodPtr->; "datePeriod"; $arrTransactionTypePtr->; "transactionType"; $arrTotalTransPtr->; "totalTrans"; $arrTransCountPtr->; "transCount"; $arrNationalityPtr->; "nationality"; $arrIDNumberPtr->; "idNumber")
	
End if 