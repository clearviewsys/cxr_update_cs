//%attributes = {}
// GAML_Get_LCT_Transactions
// Gets all transactions from Register Table required to report according to the LCT goAML Requirements

// Define transaction arrays
C_DATE:C307($1; $refStartDate; $2; $refEndDate)
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

ARRAY REAL:C219($arrDebitLocal; 0)

//$daybefore:=Add to date($refStartDate;0;0;-1)
C_REAL:C285($twoIDsLimit)
$twoIDsLimit:=<>twoIDsLimit



ARRAY TEXT:C222($arrInvoices; 0)
C_REAL:C285($sum)

READ ONLY:C145([Registers:10])
READ ONLY:C145([Customers:3])

// Get all registers related to the data range requested and filter the records

QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2>=$refStartDate; *)
QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=$refEndDate)

QUERY SELECTION:C341([Registers:10]; [Registers:10]isCash:40=True:C214)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isExported:44=False:C215)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=False:C215)
QUERY SELECTION:C341([Registers:10]; [Registers:10]DebitLocal:23>0)
CREATE SET:C116([Registers:10]; "$LCT")

RELATE ONE SELECTION:C349([Registers:10]; [Customers:3])  // load the related customers

QUERY SELECTION:C341([Customers:3]; [Customers:3]CustomerID:1#"000@")  // filter the walk-in customers
QUERY SELECTION:C341([Customers:3]; [Customers:3]isInsider:102=False:C215)  // filter out the insider customers
QUERY SELECTION:C341([Customers:3]; [Customers:3]isMSB:85=False:C215)  // filter out the MSB
QUERY SELECTION:C341([Customers:3]; [Customers:3]isWholesaler:87=False:C215)  // filter out the Wholesalers

RELATE MANY SELECTION:C340([Registers:10]CustomerID:5)  // load the Registers linked to the customers

CREATE SET:C116([Registers:10]; "$NoSpecialCust")
INTERSECTION:C121("$LCT"; "$NoSpecialCust"; "$LCT")  // intersection of LCT registers belonging to non-insiders, MSB and Wholesalers
USE SET:C118("$LCT")

// Add to the report only invoices having a SUM(DebitLocal) >= threshold
DISTINCT VALUES:C339([Registers:10]InvoiceNumber:10; $arrInvoices)

// create an array with the invoices in the same data range over the threshold
C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($arrInvoices))
	
	USE SET:C118("$LCT")
	QUERY:C277([Registers:10]; [Registers:10]InvoiceNumber:10=$arrInvoices{$i})
	$sum:=Sum:C1([Registers:10]DebitLocal:23)
	
	If ($sum>=$twoIDsLimit)
		QUERY SELECTION:C341([Registers:10]; [Registers:10]DebitLocal:23>0)
		
		// Add register records to the final array 
		While (Not:C34(End selection:C36([Registers:10])))
			APPEND TO ARRAY:C911(arrFTRegisterID; [Registers:10]RegisterID:1)
			NEXT RECORD:C51([Registers:10])
		End while 
		
		
	End if 
End for 


CLEAR SET:C117("$LCT")  // cleaning up
CLEAR SET:C117("$NoSpecialCust")

QUERY WITH ARRAY:C644([Registers:10]RegisterID:1; arrFTRegisterID)
SELECTION TO ARRAY:C260([Registers:10]RegisterDate:2; arrFTTxDate; [Registers:10]CreationDate:14; arrFTPostingDate; [Registers:10]CreationTime:15; arrFTPostingTime; [Registers:10]DebitLocal:23; arrFTDebit; [Registers:10]Currency:19; arrFTCurrencies; [Registers:10]CustomerID:5; arrFTCustomerId; [Registers:10]InvoiceNumber:10; arrFTInvoiceNumber; [Registers:10]RegisterID:1; arrFTRegisterID)

COPY ARRAY:C226(arrFTDebit; arrFTTxAmount)
SORT ARRAY:C229(arrFTCustomerID; arrFTInvoiceNumber; arrFTTxDate; arrFTPostingDate; arrFTPostingTime; arrFTDebit; arrFTCurrencies; arrFTRegisterID; arr24HourIndicator)

