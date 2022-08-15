//%attributes = {}
// selectActiveBookingsForCustomer(customerID)

C_TEXT:C284($custID; $1)
C_LONGINT:C283($0)

Case of 
	: (Count parameters:C259=1)
		$custID:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

SET QUERY DESTINATION:C396(Into current selection:K19:1)

QUERY:C277([Bookings:50]; [Bookings:50]CustomerID:2=$custID; *)
QUERY:C277([Bookings:50];  & ; [Bookings:50]isConfirmed:15=True:C214; *)
QUERY:C277([Bookings:50];  & ; [Bookings:50]isHonored:18=False:C215)
$0:=Records in selection:C76([Bookings:50])