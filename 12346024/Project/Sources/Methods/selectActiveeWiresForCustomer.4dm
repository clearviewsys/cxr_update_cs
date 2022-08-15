//%attributes = {}
// selectActiveeWiresForCustomer(CutomerID) -> number of Active eWires
// selects all the ewires that are received and still active for customer

C_TEXT:C284($1; $customerID)
C_LONGINT:C283($0)

Case of 
	: (Count parameters:C259=0)
		$customerID:="QSCUS1029205"
	: (Count parameters:C259=1)
		$customerID:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
selecteWiresForCustomer($customerID)
// filter the received ewires which are still not completed 
QUERY SELECTION:C341([eWires:13]; [eWires:13]isPaymentSent:20=False:C215; *)  // received eWires
QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]isSettled:23=False:C215; *)  // money not yet paid
QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]isCancelled:34=False:C215; *)  // that are not cancelled
QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]Status:22#"invoiced")  // already invoiced by not yet settled

$0:=Records in selection:C76([eWires:13])
