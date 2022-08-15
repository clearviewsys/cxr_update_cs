//%attributes = {}
// webSendAccountOnHoldEmail ($email)
// Send an email talking about the account is on hold


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

$body:=getEmailTemplateBody("unusualActivityAccountOnHold.html")
$subject:=getKeyValue("email.configuration.header.name")+":  Security Notificaction (Your Account is on hold) ... "
sendNotificationByEmail($email; $subject; $body)