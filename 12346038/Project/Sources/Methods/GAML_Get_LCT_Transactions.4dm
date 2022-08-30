//%attributes = {}
// GAML_Get_LCT_Transactions
// Gets all transactions from Register Table required to report according to the LCT goAML Requirements

// Define transaction arrays
C_DATE:C307($1; $refDate; $2; $refEndDate)
C_BOOLEAN:C305($3; $exported)
C_LONGINT:C283($i)

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
		$refDate:=Current date:C33(*)
		$refEndDate:=Current date:C33(*)
		$exported:=False:C215
		
	: (Count parameters:C259=1)
		$refDate:=$1
		$refEndDate:=$1
		$exported:=False:C215
		
	: (Count parameters:C259=2)
		$refDate:=$1
		$refEndDate:=$2
		$exported:=False:C215
		
	: (Count parameters:C259=3)
		$refDate:=$1
		$refEndDate:=$2
		$exported:=$3
		
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY REAL:C219($arrDebitLocal; 0)


C_REAL:C285($twoIDsLimit; $sumDebitLC)
$twoIDsLimit:=<>twoIDsLimit
ARRAY TEXT:C222($arrInvoices; 0)


READ ONLY:C145([Registers:10])
READ ONLY:C145([Customers:3])
READ ONLY:C145([Accounts:9])

QUERY:C277([Invoices:5]; [Invoices:5]invoiceDate:44=$refDate)


QUERY SELECTION:C341([Invoices:5]; [Invoices:5]isCancelled:84=False:C215)

CREATE EMPTY SET:C140([Invoices:5]; "$set1")
CREATE EMPTY SET:C140([Invoices:5]; "$set2")

FIRST RECORD:C50([Invoices:5])

While (Not:C34(End selection:C36([Invoices:5])))
	
	
	If (GAML_IsInvoiceReportable([Invoices:5]InvoiceID:1; $refDate; (operationMode=0)))
		ADD TO SET:C119([Invoices:5]; "$set1")
	End if 
	
	NEXT RECORD:C51([Invoices:5])
	
End while 

USE SET:C118("$set1")


// Get Registers Cash transactions
RELATE MANY SELECTION:C340([Registers:10]InvoiceNumber:10)  // load the related registers
QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=False:C215)
QUERY SELECTION:C341([Registers:10]; [Registers:10]DebitLocal:23>0)  // received cash only



SELECTION TO ARRAY:C260([Registers:10]RegisterID:1; arrALLRegisterID; [Registers:10]RegisterDate:2; arrFTTxDate; [Registers:10]CreationDate:14; arrFTPostingDate; [Registers:10]CreationTime:15; arrFTPostingTime; [Registers:10]DebitLocal:23; arrFTDebit; [Registers:10]Currency:19; arrFTCurrencies; [Registers:10]CustomerID:5; arrFTCustomerId; [Registers:10]InvoiceNumber:10; arrFTInvoiceNumber; [Registers:10]RegisterID:1; arrFTRegisterID)
COPY ARRAY:C226(arrALLRegisterID; arrFTRegisterID)
COPY ARRAY:C226(arrFTDebit; arrFTTxAmount)
SORT ARRAY:C229(arrFTCustomerID; arrFTInvoiceNumber; arrFTTxDate; arrFTPostingDate; arrFTPostingTime; arrFTDebit; arrFTCurrencies; arrFTRegisterID; arrALLRegisterID; arr24HourIndicator)

