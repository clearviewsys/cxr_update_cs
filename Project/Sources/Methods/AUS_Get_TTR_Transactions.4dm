//%attributes = {}
// AUS_Get_TTR_Transactions
// Gets all transactions from Register Table required to report according to the TTR Austrac Requirements

// Define transaction arrays
C_DATE:C307($1; $refStartDate; $2; $refEndDate; $refDate)
C_BOOLEAN:C305($3; $exported)

C_DATE:C307($daybefore)
ARRAY TEXT:C222($arrCustomersId; 0)

ARRAY REAL:C219(arrFTDebit; 0)
ARRAY DATE:C224(arrFTTxDate; 0)

ARRAY TEXT:C222(arrFTCustomerID; 0)
ARRAY TEXT:C222(arrFTCustomerID2; 0)

ARRAY TEXT:C222(arrFTCurrencies; 0)
ARRAY DATE:C224(arrFTPostingDate; 0)

ARRAY TEXT:C222(arrFTInvoiceNumber; 0)
ARRAY TEXT:C222(arrFTInvoiceNumber2; 0)

ARRAY LONGINT:C221(arrFTPostingTime; 0)

ARRAY REAL:C219(arrFTTxAmount; 0)
ARRAY TEXT:C222(arrFTRegisterID; 0)
ARRAY BOOLEAN:C223(arr24HourIndicator; 0)
ARRAY TEXT:C222(arrFTRegisterIDtmp; 0)

Case of 
	: (Count parameters:C259=0)
		$refStartDate:=Current date:C33(*)
		$refEndDate:=Current date:C33(*)
		$exported:=False:C215
		
	: (Count parameters:C259=1)
		$refStartDate:=$1
		$refEndDate:=$1
		$refDate:=$1
		$exported:=False:C215
		
	: (Count parameters:C259=2)
		$refStartDate:=$1
		$refEndDate:=$2
		$exported:=False:C215
		
	: (Count parameters:C259=3)
		$refStartDate:=$1
		$refEndDate:=$2
		$exported:=$3
		
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($i)
ARRAY REAL:C219($arrDebitLocal; 0)


C_REAL:C285($twoIDsLimit; $sumDebitLC)
$twoIDsLimit:=<>twoIDsLimit
ARRAY TEXT:C222($arrInvoices; 0)


READ ONLY:C145([Registers:10])
READ ONLY:C145([Customers:3])
READ ONLY:C145([Accounts:9])
READ ONLY:C145([Invoices:5])
READ ONLY:C145([Links:17])


// FJ_Get_CTR_Transactions
// Gets all transactions from Register Table required to report according to the LCT goAML Requirements

// Define transaction arrays
C_DATE:C307($1; $refStartDate; $2; $refEndDate; $refDate)
C_BOOLEAN:C305($3; $exported)

C_DATE:C307($daybefore)
ARRAY TEXT:C222($arrCustomersId; 0)

ARRAY REAL:C219(arrFTDebit; 0)
ARRAY DATE:C224(arrFTTxDate; 0)

ARRAY TEXT:C222(arrFTCustomerID; 0)
ARRAY TEXT:C222(arrFTCustomerID2; 0)

ARRAY TEXT:C222(arrFTCurrencies; 0)
ARRAY DATE:C224(arrFTPostingDate; 0)

ARRAY TEXT:C222(arrFTInvoiceNumber; 0)
ARRAY TEXT:C222(arrFTInvoiceNumber2; 0)

ARRAY LONGINT:C221(arrFTPostingTime; 0)

ARRAY REAL:C219(arrFTTxAmount; 0)
ARRAY TEXT:C222(arrFTRegisterID; 0)
ARRAY BOOLEAN:C223(arr24HourIndicator; 0)
ARRAY TEXT:C222(arrFTRegisterIDtmp; 0)

Case of 
	: (Count parameters:C259=0)
		$refStartDate:=Current date:C33(*)
		$refEndDate:=Current date:C33(*)
		$exported:=False:C215
		
	: (Count parameters:C259=1)
		$refStartDate:=$1
		$refEndDate:=$1
		$refDate:=$1
		$exported:=False:C215
		
	: (Count parameters:C259=2)
		$refStartDate:=$1
		$refEndDate:=$2
		$exported:=False:C215
		
	: (Count parameters:C259=3)
		$refStartDate:=$1
		$refEndDate:=$2
		$exported:=$3
		
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_LONGINT:C283($p; $j; $i)

ARRAY TEXT:C222($records; 0)
ARRAY REAL:C219($acum; 0)
ARRAY TEXT:C222($acumCustID; 0)
ARRAY TEXT:C222($nvoicesXCust; 0)
C_BOOLEAN:C305($loadListContinue)
ARRAY REAL:C219($arrDebitLocal; 0)
C_REAL:C285($threshold; $sumDebitLC)

$threshold:=<>twoIDsLimit
ARRAY TEXT:C222($arrInvoices; 0)

C_LONGINT:C283($i)
C_REAL:C285($totCash; $totalBankDrafs; $totalBankCheques)
C_OBJECT:C1216($invoiceTotals)


QUERY:C277([Invoices:5]; [Invoices:5]invoiceDate:44=$refDate; *)
QUERY:C277([Invoices:5];  & ; [Invoices:5]isCancelled:84=False:C215)

CREATE EMPTY SET:C140([Invoices:5]; "$set1")

C_BOOLEAN:C305($progressBar)
$progressBar:=True:C214

If ($progressBar)
	C_REAL:C285($loadListCount; $loadListTotal)
	$loadListTotal:=Records in selection:C76([Invoices:5])
	
	C_LONGINT:C283($loadListProgress)
	$loadListProgress:=Progress New
	Progress SET WINDOW VISIBLE(True:C214)
	Progress SET TITLE($loadListProgress; "Getting Transactions. Date: "+String:C10($refStartDate))
	Progress SET PROGRESS($loadListProgress; 0)
	Progress SET MESSAGE($loadListProgress; "Completed 0 of "+String:C10($loadListTotal))
	Progress SET BUTTON ENABLED($loadListProgress; True:C214)
End if 


While (Not:C34(End selection:C36([Invoices:5])))
	
	If ($progressBar)
		//if ($loadListCount%10=0)
		C_REAL:C285($loadListPrecent)
		C_TEXT:C284($msg)
		$loadListPrecent:=$loadListCount/$loadListTotal
		//Progress SET TITLE ($loadListProgress;"Processing invoice: "+[Invoices]InvoiceID)
		Progress SET PROGRESS($loadListProgress; $loadListPrecent)
		//$msg:="Analyzing invoice: "+[Invoices]InvoiceID+" "+[Invoices]CustomerFullName+".Completed "+String($loadListCount)+" of "+String($loadListTotal)
		$msg:="Analyzing invoice: "+[Invoices:5]InvoiceID:1+".\nCompleted "+String:C10($loadListCount)+" of "+String:C10($loadListTotal)+".   "+String:C10(($loadListCount/$loadListTotal)*100; "##0.0")+"%"
		Progress SET MESSAGE($loadListProgress; $msg)
		$loadListCount:=$loadListCount+1
		//DELAY PROCESS(Current process;40)
		$loadListContinue:=Not:C34(Progress Stopped($loadListProgress))
		//End if 
	End if 
	
	
	
	If (isCustomerReportable([Invoices:5]CustomerID:2))
		
		QUERY:C277([Registers:10]; [Registers:10]InvoiceNumber:10=[Invoices:5]InvoiceID:1)
		QUERY SELECTION:C341([Registers:10]; [Registers:10]DebitLocal:23>0)
		
		$p:=Find in array:C230($acumCustId; [Invoices:5]CustomerID:2)
		
		If ($p>0)
			$acum{$p}:=$acum{$p}+Sum:C1([Registers:10]DebitLocal:23)
			$nvoicesXCust{$p}:=$nvoicesXCust{$p}+","+[Invoices:5]InvoiceID:1
		Else 
			APPEND TO ARRAY:C911($acumCustID; [Invoices:5]CustomerID:2)
			APPEND TO ARRAY:C911($acum; Sum:C1([Registers:10]DebitLocal:23))
			APPEND TO ARRAY:C911($nvoicesXCust; [Invoices:5]InvoiceID:1)
		End if 
		
		
	End if 
	
	
	NEXT RECORD:C51([Invoices:5])
End while 

If ($progressBar)
	Progress SET WINDOW VISIBLE(False:C215)
	Progress QUIT($loadListProgress)
End if   // $progressBar


For ($i; 1; Size of array:C274($acum))
	
	If ($acum{$i}>=$threshold)
		
		CLEAR VARIABLE:C89($records)
		tokenizePhraseIntoWords($nvoicesXCust{$i}; ->$records; ",")
		
		For ($j; 1; Size of array:C274($records))
			QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=$records{$j})
			ADD TO SET:C119([Invoices:5]; "$set1")
			APPEND TO ARRAY:C911(arrInvoicesReport; [Invoices:5]InvoiceID:1)
		End for 
	End if 
	
	//If (isCashTxOverThreshold ($arrInvoices{$i};$threshold))
	//ADD TO SET([Invoices];"$set1")
	//End if 
	
End for 

USE SET:C118("$set1")

RELATE ONE SELECTION:C349([Invoices:5]; [Registers:10])
QUERY SELECTION:C341([Registers:10]; [Registers:10]DebitLocal:23>0)

For ($i; 1; Records in selection:C76([Registers:10]))
	APPEND TO ARRAY:C911(arrALLRegisterID; [Registers:10]RegisterID:1)
	APPEND TO ARRAY:C911(arrFTRegisterID; [Registers:10]RegisterID:1)
	NEXT RECORD:C51([Registers:10])
End for 

// --------------------------------------------------

QUERY WITH ARRAY:C644([Registers:10]RegisterID:1; arrFTRegisterID)
SELECTION TO ARRAY:C260([Registers:10]RegisterDate:2; arrFTTxDate; [Registers:10]CreationDate:14; arrFTPostingDate; [Registers:10]CreationTime:15; arrFTPostingTime; [Registers:10]DebitLocal:23; arrFTDebit; [Registers:10]Currency:19; arrFTCurrencies; [Registers:10]CustomerID:5; arrFTCustomerId; [Registers:10]InvoiceNumber:10; arrFTInvoiceNumber; [Registers:10]RegisterID:1; arrFTRegisterID)

COPY ARRAY:C226(arrFTDebit; arrFTTxAmount)
SORT ARRAY:C229(arrFTCustomerID; arrFTInvoiceNumber; arrFTTxDate; arrFTPostingDate; arrFTPostingTime; arrFTDebit; arrFTCurrencies; arrFTRegisterID; arr24HourIndicator)
CLEAR SET:C117("$set1")