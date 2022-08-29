//%attributes = {"publishedWeb":true}
// webSendConfirmationEmail ($email; $token)
// Send an email with the confirmation token 


C_TEXT:C284($1; $email; $2; $token)

C_BLOB:C604($blobTemplate)
C_TEXT:C284($subject; $body; $htmlFile)
C_LONGINT:C283($error)

Case of 
	: (Count parameters:C259=2)
		
		$email:=$1
		$token:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


$body:=getEmailTemplateBody("welcome.html")

$body:=Replace string:C233($body; "[webToken]"; $token)

$subject:=getKeyValue("web.configuration.header.name")+":  Please Complete your Registration ... "

sendNotificationByEmail($email; $subject; $body)