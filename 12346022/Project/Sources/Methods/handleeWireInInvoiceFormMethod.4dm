//%attributes = {}
// handleWireInvoiceFormMethod (isPaymentSent)
C_BOOLEAN:C305($isPaymentSent; $1)
$isPaymentSent:=$1

If (onNewRecordEvent)
	C_REAL:C285($oldRemaining; vRemaining)
	[eWires:13]eWireID:1:=makeeWireID
	
	[eWires:13]InvoiceNumber:29:=vInvoiceNumber
	[eWires:13]CustomerID:15:=vCustomerID
	[eWires:13]SenderName:7:=[Customers:3]FullName:40
	// the reason I commented the folowing lines is:
	// sometimes we may want to pay in part cheque and part eWire
	// or even have multiple eWire payments in one
	//[eWires]FromAmount:=vRemaining
	//[eWires]FromCurrency:=vFromCurrency
	[eWires:13]isPaymentSent:20:=$isPaymentSent
	If ($isPaymentSent)
		[eWires:13]ToAmount:14:=vRemainPaid
		[eWires:13]Currency:12:=vToCurrency
		[eWires:13]AccountID:30:=makeeWirePayable(vToCurrency)  // payable account
		//[eWires]fromCountry:=<>CompanyCountry
		
	Else 
		[eWires:13]FromAmount:13:=vRemainReceive
		[eWires:13]FromCurrency:11:=vFromCurrency
		[eWires:13]AccountID:30:=makeeWireReceivable(vFromCurrency)  // receivable account
		[eWires:13]fromCountry:9:=""
	End if 
	
	QUERY:C277([Links:17]; [Links:17]CustomerID:14=vCustomerID)
	If (Records in selection:C76([Links:17])>0)
		SELECTION TO ARRAY:C260([Links:17]LinkID:1; arrLInkIDs; [Links:17]FullName:4; arrLinkNames; [Links:17]City:11; arrLinkCities)
		arrLinkIDs:=1  // select the first element
		arrLinkNames:=1
		arrLinkCities:=1
		handleLinkListArrays  // click on the first row and select it
	Else 
		ARRAY TEXT:C222(arrLinkIDs; 0)
		ARRAY TEXT:C222(arrLinkNames; 0)
		ARRAY TEXT:C222(arrLinkCities; 0)
	End if 
	
	arrPartnerBank:=0
	unloadRecordBanks
	
End if 


handleCloseBox

