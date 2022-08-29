//%attributes = {}
// testWebEmailTemplate


C_TEXT:C284($1; $email; $2; $subject; $3; $htmlBody; $htmltemplate)

C_BLOB:C604($blobTemplate)
C_TEXT:C284($htmlFile; $body)
C_LONGINT:C283($error)

Case of 
	: (Count parameters:C259=3)
		
		$email:=$1
		$subject:=$2
		$htmlBody:=$3
		
		// example $3  should be in HTML
		$htmltemplate:="Template_email_test"
		$htmlBody:="<h3>Welcome</h3>"
		$htmlBody:=$htmlBody+"<p>Test Paragraph</p>"
		
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 



$htmlFile:=getEmailTemplateFolder+$htmltemplate
DOCUMENT TO BLOB:C525($htmlFile; $blobTemplate)
$body:=BLOB to text:C555($blobTemplate; UTF8 text without length:K22:17)
$body:=Replace string:C233($body; "[xxBodyxx]"; $htmlBody)

$error:=sendEmail($email; $subject; $body)