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

QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2=$refDate)
SET FIELD RELATION:C919([Registers:10]AccountID:6; Automatic:K51:4; Manual:K51:3)

QUERY SELECTION BY FORMULA:C207([Registers:10]; [Accounts:9]isCashAccount:3=True:C214)  // cash only transactions (dynamic search)

SET FIELD RELATION:C919([Registers:10]AccountID:6; Manual:K51:3; Manual:K51:3)

QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=False:C215)
QUERY SELECTION:C341([Registers:10]; [Registers:10]DebitLocal:23>0)  // received cash only
QUERY SELECTION:C341([Registers:10]; [Registers:10]isExported:44=False:C215)

RELATE ONE SELECTION:C349([Registers:10]; [Customers:3])  // load the related customers

// Get Registers Cash transactions
RELATE ONE SELECTION:C349([Registers:10]; [Customers:3])  // load the related customers

QUERY SELECTION:C341([Customers:3]; [Customers:3]isWalkin:36=False:C215)  // filter out the Walk-in Customers
QUERY SELECTION:C341([Customers:3]; [Customers:3]CustomerID:1#"000@")  // filter out the Walk-in Customers
QUERY SELECTION:C341([Customers:3]; [Customers:3]isInsider:102=False:C215)  // filter out the insider customers
QUERY SELECTION:C341([Customers:3]; [Customers:3]isMSB:85=False:C215)  // filter out the MSB
QUERY SELECTION:C341([Customers:3]; [Customers:3]isWholesaler:87=False:C215)  // filter out the Wholesalers
FIRST RECORD:C50([Customers:3])

While (Not:C34(End selection:C36([Customers:3])))
	
	$sumDebitLC:=AUS_queryRegistersTTR([Customers:3]CustomerID:1; $refDate)
	
	If ($sumDebitLC>=$twoIDsLimit)
		// Add register records to the final array 
		
		For ($i; 1; Records in selection:C76([Registers:10]))
			APPEND TO ARRAY:C911(arrALLRegisterID; [Registers:10]RegisterID:1)
			APPEND TO ARRAY:C911(arrFTRegisterID; [Registers:10]RegisterID:1)
			NEXT RECORD:C51([Registers:10])
		End for 
		
		
	End if 
	
	NEXT RECORD:C51([Customers:3])
End while 

QUERY WITH ARRAY:C644([Registers:10]RegisterID:1; arrFTRegisterID)
SELECTION TO ARRAY:C260([Registers:10]RegisterDate:2; arrFTTxDate; [Registers:10]CreationDate:14; arrFTPostingDate; [Registers:10]CreationTime:15; arrFTPostingTime; [Registers:10]DebitLocal:23; arrFTDebit; [Registers:10]Currency:19; arrFTCurrencies; [Registers:10]CustomerID:5; arrFTCustomerId; [Registers:10]InvoiceNumber:10; arrFTInvoiceNumber; [Registers:10]RegisterID:1; arrFTRegisterID)

COPY ARRAY:C226(arrFTDebit; arrFTTxAmount)
SORT ARRAY:C229(arrFTCustomerID; arrFTInvoiceNumber; arrFTTxDate; arrFTPostingDate; arrFTPostingTime; arrFTDebit; arrFTCurrencies; arrFTRegisterID; arr24HourIndicator)

