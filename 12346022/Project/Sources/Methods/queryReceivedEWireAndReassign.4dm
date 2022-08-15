//%attributes = {}
// queryReceivedEWireAndReassign (eWireID;newCustomerID) ->success



C_TEXT:C284($eWireID; $customerID)
C_BOOLEAN:C305($0)

$eWireID:=$1
$customerID:=$2


QUERY:C277([eWires:13]; [eWires:13]eWireID:1=$eWireID)
If (Records in selection:C76([eWires:13])=1)
	READ WRITE:C146([eWires:13])
	LOAD RECORD:C52([eWires:13])
	
	[eWires:13]FromAmount:13:=[eWires:13]ToAmount:14
	[eWires:13]ToAmount:14:=0
	[eWires:13]isPaymentSent:20:=False:C215  // eWire Received
	[eWires:13]customerID_origin:84:=[eWires:13]CustomerID:15
	[eWires:13]invoiceID_origin:86:=[eWires:13]InvoiceNumber:29
	[eWires:13]linkID_origin:85:=[eWires:13]LinkID:8
	[eWires:13]registerID_origin:91:=[eWires:13]RegisterID:24
	[eWires:13]RegisterID:24:=""
	[eWires:13]LinkID:8:=""
	[eWires:13]InvoiceNumber:29:=""
	[eWires:13]CustomerID:15:=$CustomerID
	
	SAVE RECORD:C53([eWires:13])
	UNLOAD RECORD:C212([eWires:13])
	READ ONLY:C145([eWires:13])
	$0:=True:C214
Else 
	$0:=False:C215  //unsuccessful
End if 