//%attributes = {}
// selectActiveeWiresForCustomer(CutomerID) -> number of Active eWires
// selects all the ewires that are received and still active for customer

C_TEXT:C284($1; $customerID)
C_TEXT:C284($2; $type)
C_LONGINT:C283($0)

Case of 
	: (Count parameters:C259=0)
		$customerID:="QSCUS1029205"
		$type:="ewire"
	: (Count parameters:C259=1)
		$customerID:=$1
		$type:="ewire"
	: (Count parameters:C259=2)
		$customerID:=$1
		$type:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
SET QUERY DESTINATION:C396(Into current selection:K19:1)

READ ONLY:C145([WebEWires:149])

QUERY:C277([WebEWires:149]; [WebEWires:149]CustomerID:21=$customerID; *)
QUERY:C277([WebEWires:149];  & ; [WebEWires:149]eWireID:18=""; *)
QUERY:C277([WebEWires:149];  & ; [WebEWires:149]status:16=20; *)

Case of 
	: ($type="MG")
		QUERY:C277([WebEWires:149];  & ; [WebEWires:149]WebEwireID:1="@MGS@")
	: ($type="wire")
		QUERY:C277([WebEWires:149];  & ; [WebEWires:149]WebEwireID:1="@WIR@")
	Else   //this will be fallback ewire
		QUERY:C277([WebEWires:149];  & ; [WebEWires:149]WebEwireID:1#"@MGS@"; *)  //not moneygram
		QUERY:C277([WebEWires:149];  & ; [WebEWires:149]WebEwireID:1#"@WIR@")  //not wire
End case 


$0:=Records in selection:C76([WebEWires:149])
