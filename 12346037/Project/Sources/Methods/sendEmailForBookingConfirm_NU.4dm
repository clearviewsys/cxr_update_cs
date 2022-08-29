//%attributes = {}
//sendEmailForBookingConfirmation

//6/27/20 - old method - see: 
//createEmailBookingStatusChange

C_TEXT:C284($email; $body; $subject)
C_LONGINT:C283($0; $error)

$error:=0
$email:=[Customers:3]Email:17

C_TEXT:C284($processName; $tFilePath)
C_LONGINT:C283($processState; $processTime; $processID; $processOrigin)
C_BOOLEAN:C305($processVisible; $bAlert)
C_TEXT:C284(percentage; headerText)

PROCESS PROPERTIES:C336(Current process:C322; $processName; $processState; $processTime; $processVisible; $processID; $processOrigin)

$bAlert:=False:C215
Case of 
	: ($processOrigin=Web process on 4D remote:K36:17)  //no dialog in web process
	: ($processOrigin=Web process with no context:K36:8)
	: ($processOrigin=Web server process:K36:18)
	Else 
		$bAlert:=True:C214
		If ($email="")
			myAlert("We don't have an email for this customer.")
		End if 
		$email:=Request:C163("Send email to:"; $email; "Send Email"; "Cancel")
End case 

If ((OK=1) & ($email#""))
	$tFilePath:=getEmailTemplateFolder+"bookings-new-record.html"
	If (Test path name:C476($tFilePath)=Is a document:K24:1)
		$body:=Document to text:C1236($tFilePath)
		PROCESS 4D TAGS:C816($body; $body)
	Else 
		$body:=makeEmailBodyForBooking
	End if 
	
	If (OK=1)
		$subject:="Booking Confirmation "+[Bookings:50]BookingID:1
		
		If (True:C214)  // create a notification table
			sendNotificationByEmail($email; $subject; $body)
			If ($bAlert)
				myAlert("Email will be sent in a moment.")
			End if 
		End if 
		
		If (False:C215)  //let the notification process table do the emailing
			$error:=sendEmailUsingServerSettings($email; $subject; $body)
			If ($error=0)
				If ($bAlert)
					myAlert("Email sent"+CRLF+$body)
				End if 
			Else 
				If ($bAlert)
					myAlert("Email could not be sent.")
				End if 
			End if 
			$0:=$error
		End if 
	End if 
End if 