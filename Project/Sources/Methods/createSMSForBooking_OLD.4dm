//%attributes = {}


C_TEXT:C284($1; $number)

C_LONGINT:C283($0; $error)

C_OBJECT:C1216($entity)
C_TEXT:C284($message)

$error:=0

If (Count parameters:C259=1)
	$number:=$1
Else 
	$entity:=ds:C1482.Customers.query("CustomerID == :1"; [Bookings:50]CustomerID:2)
	$number:=$entity.first().CellPhone
End if 

If ($number="")
	$error:=-1
Else 
	Case of 
		: ([Bookings:50]isConfirmed:15) & ([Bookings:50]isHonored:18)
			$message:="Your booking has been honored: "
			
		: ([Bookings:50]isConfirmed:15)
			$message:="Your booking has been confirmed: "
			
		: ([Bookings:50]isHonored:18)  //this shouldn';t happened
			$message:="Your booking has been honored: "
			
		Else 
			$message:="Your booking has been submitted: "
	End case 
	
	$message:=$message+"["+[Bookings:50]BookingID:1+"]"
	sendNotificationBySMS($number; $message)
End if 


$0:=$error

