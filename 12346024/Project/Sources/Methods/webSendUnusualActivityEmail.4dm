//%attributes = {}
// webSendUnusualActivityEmail ($email)
// Send an email with the Unusual Activity warning message


C_TEXT:C284($1; $email)
C_TEXT:C284($2; $activity)

C_BLOB:C604($blobTemplate)
C_TEXT:C284($subject; $body; $htmlFile)
C_LONGINT:C283($error)

Case of 
	: (Count parameters:C259=1)
		$email:=$1
		$activity:=""
		
	: (Count parameters:C259=2)
		$email:=$1
		$activity:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


//$htmlFile:=getEmailTemplateFolder +"portal-unusualActivity.html"
//DOCUMENT TO BLOB($htmlFile;$blobTemplate)
//$body:=BLOB to text($blobTemplate;UTF8 text without length)
//PROCESS 4D TAGS($body;$body)

$body:=getEmailTemplateBody("unusualActivity.html")
$body:=Replace string:C233($body; "[activity]"; $activity)

$subject:=getKeyValue("email.configuration.header.name")+": Security Notificaction (Unusual activity on your Account) ... "
sendNotificationByEmail($email; $subject; $body)
//$error:=sendEmail ($email;$subject;$body)