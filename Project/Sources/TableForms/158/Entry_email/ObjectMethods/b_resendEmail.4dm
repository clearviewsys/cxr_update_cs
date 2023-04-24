C_OBJECT:C1216($obMessage)
C_LONGINT:C283($error)
If (Form:C1466.message#Null:C1517)
	$obMessage:=Form:C1466.message
	Case of 
		: (Form:C1466.message.message="@CID:embedded@") & (Form:C1466.message.attachments#Null:C1517)  // with content id referring to the embedded image
			$error:=sendEmailviaSMTP(Form:C1466.message.to; Form:C1466.message.subject; Form:C1466.message.message; Form:C1466.message.attachments)
		: (Form:C1466.message.attachments#Null:C1517)
			$error:=sendEmailUsingServerSettings(Form:C1466.message.to; Form:C1466.message.subject; Form:C1466.message.message; Form:C1466.message.attachments)
		Else 
			$error:=sendEmailUsingServerSettings(Form:C1466.message.to; Form:C1466.message.subject; Form:C1466.message.message)
	End case 
	
	Case of 
		: ($error=0)
			//not sure what else in the $entity.response object needs updating
			Form:C1466.response.status:="Success"
			Form:C1466.response.code:=$error
			Form:C1466.status:=1
			Form:C1466.save()
			myAlert("Email sent")
		Else   //failed to send 
			//not sure what else in the $entity.response object needs updating
			Form:C1466.response.status:="Failed"
			Form:C1466.response.failedAttempts:=Form:C1466.response.failedAttempts+1
			Form:C1466.response.code:=$error
			Form:C1466.status:=-1
			Form:C1466.save()
			myAlert("Email sending failed.")
	End case 
End if 
