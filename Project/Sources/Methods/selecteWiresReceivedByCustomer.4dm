//%attributes = {}
// selecteWiresSentByCustomer (customerID)
// selecteWiresSentByCustomer (customerID;{true})` will query into selection

C_TEXT:C284($customerID; $1)
C_LONGINT:C283($2)

C_LONGINT:C283($count; $0)
$customerID:=$1

If (Count parameters:C259=2)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $count)
Else 
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
End if 

QUERY:C277([eWires:13]; [eWires:13]isSettled:23=False:C215; *)
QUERY:C277([eWires:13];  & ; [eWires:13]isPaymentSent:20=False:C215; *)
QUERY:C277([eWires:13];  & ; [eWires:13]isCancelled:34=False:C215; *)
QUERY:C277([eWires:13];  & ; [eWires:13]CustomerID:15=$customerID)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

$0:=$count


