//%attributes = {}
C_TEXT:C284($message; $toNumber; $error; $status)
C_POINTER:C301($pError)

$error:=""
$message:="Test message"
$toNumber:="15551234567"
$pError:=->$error

$status:=twilioSendSMS($pError; $toNumber; $message)

If ($status="200")
	myAlert("Success sending SMS")
Else 
	myAlert("Error: "+$status+" When sending SMS. Message: "+$error)
End if 