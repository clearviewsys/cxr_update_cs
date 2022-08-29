//%attributes = {}
// FT_Get_LCTR_Transactions
// Gets all transactions from Register Table required to report according to FINTRAC Requirements

// Define transaction arrays
C_BOOLEAN:C305($1; $exported)

ARRAY REAL:C219(arrFTDebit; 0)
ARRAY DATE:C224(arrFTTxDate; 0)

ARRAY TEXT:C222(arrFTCustomerID; 0)
ARRAY TEXT:C222(arrFTCustomerID2; 0)

ARRAY TEXT:C222(arrFTCurrencies; 0)
ARRAY DATE:C224(arrFTPostingDate; 0)

ARRAY TEXT:C222(arrFTInvoiceNumber; 0)
ARRAY LONGINT:C221(arrFTPostingTime; 0)

ARRAY REAL:C219(arrFTTxAmount; 0)
ARRAY TEXT:C222(arrFTRegisterID; 0)
ARRAY BOOLEAN:C223(arr24HourIndicator; 0)
ARRAY TEXT:C222(arrFTBranchId; 0)


Case of 
		
	: (Count parameters:C259=0)
		$exported:=False:C215
		
	: (Count parameters:C259=1)
		$exported:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_DATE:C307($refDate; $daybefore)
$refDate:=initialDate

ARRAY BOOLEAN:C223(arr24HourIndicator; 0)
ARRAY TEXT:C222($arrInvoices; 0)

FT_Get_LCTR_InvoicesByQuery($refDate; ->$arrInvoices; ->arr24HourIndicator)


QUERY WITH ARRAY:C644([Registers:10]InvoiceNumber:10; $arrInvoices)

QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=Add to date:C393($refDate; 0; 0; -1); *)
QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=$refDate; *)

QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]Debit:8>0; *)
QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]isCash:40=True:C214; *)
QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]isCancelled:59=False:C215; *)
QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]isTransfer:3=False:C215)
//QUERY SELECTION([Registers]; & ;[Registers]isExported=$exported)

