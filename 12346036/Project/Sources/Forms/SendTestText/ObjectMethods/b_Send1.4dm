C_TEXT:C284($error; $message)
C_POINTER:C301($pError)
$error:=""
$pError:=->$error
$message:="This is a test message from CXR using Twilio."

If (True:C214)
	sendNotificationBySMS(Form:C1466.toNumber; $message)
Else 
	twilioSendSMS($pError; Form:C1466.toNumber; $message)
	
	If ($error#"")
		myAlert($error)
		REJECT:C38
	Else 
		myAlert("Test message has been sent")
	End if 
End if 