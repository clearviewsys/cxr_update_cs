//%attributes = {}
// webSendPasswordChangedEmail ($email)
// Send a warning by email informing that password has been changed


C_TEXT:C284($1; $email)

C_BLOB:C604($blobTemplate)
C_TEXT:C284($subject; $body; $htmlFile)
C_LONGINT:C283($error)

Case of 
	: (Count parameters:C259=1)
		$email:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

//$htmlFile:=getEmailTemplateFolder +"portal-PasswordChanged.html"
//DOCUMENT TO BLOB($htmlFile;$blobTemplate)
//$body:=BLOB to text($blobTemplate;UTF8 text without length)
//PROCESS 4D TAGS($body;$body)

$body:=getEmailTemplateBody("PasswordChanged.html")

$subject:=getKeyValue("email.configuration.header.name")+":  Security Notification (Password Changed)"
sendNotificationByEmail($email; $subject; $body)
//$error:=sendEmail ($email;$subject;$body)