//sendEmailForBookingConfirmation 
var $success : Integer
var $email : Text

$email:=Request:C163("Enter the email address(s) to send to:"; ds:C1482.Customers.query("CustomerID == :1"; [Bookings:50]CustomerID:2).first().Email; "Send"; "Cancel")

If ($email#"") & (OK=1)
	$success:=sendNotificationEmailForBooking($email)
	If ($success=0)
		myAlert("The email will be sent shortly. ")
	Else 
		myAlert("Email not sent. Customer does not have a valid email address. Please update. ")
	End if 
End if 