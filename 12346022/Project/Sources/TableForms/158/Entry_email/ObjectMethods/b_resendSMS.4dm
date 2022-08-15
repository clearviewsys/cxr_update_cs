
C_TEXT:C284($errorMessage)
C_POINTER:C301($pError)
C_LONGINT:C283($error)
If (Form:C1466.message.toNumber#"")
	$errorMessage:=""
	$error:=Num:C11(twilioSendSMS(->$errorMessage; Form:C1466.message.to; Form:C1466.message.message))
	Case of 
		: ($error=200)  //success
			$error:=0
		: ($error=400)  //not enough money - send email to alert someone?
			sendNotificationByEmail("barclay@clearviewsys.com"; "Twilio needs money"; "please add funds")  //testing
		Else 
			//just relay the error number and message from twilio
	End case 
	
	Case of 
		: ($error=0)
			//not sure what else in the $entity.response object needs updating
			Form:C1466.response.status:="Success"
			Form:C1466.response.code:=$error
			Form:C1466.status:=1
			Form:C1466.save()
			myAlert("SMS sent")
		Else   //failed to send 
			//not sure what else in the $entity.response object needs updating
			Form:C1466.response.status:="Failed"
			Form:C1466.response.failedAttempts:=Form:C1466.response.failedAttempts+1
			Form:C1466.response.code:=$error
			Form:C1466.response.message:=$errorMessage
			Form:C1466.status:=-1
			Form:C1466.save()
			myAlert($errorMessage)
	End case 
	
End if 