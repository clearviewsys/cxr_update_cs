//%attributes = {}
// webSendChangePasswordEmail ($email; $token)
// Send an email with the confirmation token 


C_TEXT:C284($1; $email; $2; $token)

C_BLOB:C604($blobTemplate)
C_TEXT:C284($subject; $body; $htmlFile)
C_LONGINT:C283($webMessageType; $error)

Case of 
	: (Count parameters:C259=2)
		
		$email:=$1
		$token:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$body:=getEmailTemplateBody("ChangePassword.html")
$body:=Replace string:C233($body; "[webToken]"; $token)


$subject:=getKeyValue("email.configuration.header.name")+":  Security Notificaction (Change password request) ... "
sendNotificationByEmail($email; $subject; $body)
