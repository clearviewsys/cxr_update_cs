//%attributes = {}
//createEmailBooking

C_TEXT:C284($1; $email)


C_TEXT:C284($body; $subject)
C_LONGINT:C283($0; $error)  //[AgentAccounts]

C_BOOLEAN:C305($honorChange; $confirmChange)
C_OBJECT:C1216($entity)
C_TEXT:C284($tFilePath)
C_LONGINT:C283($error)

If (Count parameters:C259>=1)
	$email:=$1
Else 
	$entity:=ds:C1482.Customers.query("CustomerID == :1"; [Bookings:50]CustomerID:2)
	$email:=$entity.first().Email
End if 

$error:=0

If ($email="")
	$error:=-1
Else 
	
	$body:=getEmailTemplateBody("bookings-new-record.html"; ->[Bookings:50])  //WAPI_getSession ("context"))
	If ($body="")
		$body:=makeEmailBodyForBooking
	End if 
	
	If (OK=1)
		$subject:="Booking Confirmation "+[Bookings:50]BookingID:1
		sendNotificationByEmail($email; $subject; $body)
	Else 
		$error:=-2
	End if 
	
	
End if 

$0:=$error