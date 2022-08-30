//%attributes = {}
// sendQuickEmailUsingJavaMailer (toEmail; subject; message)
// PRE: The MailSender_fat.jar must be installed in the root of the drive
// Java must be installed
// SMTP2GO should be configured and current

C_TEXT:C284($command; $email; $subject; $subject; $input; $output; $error; $0; $body)

$command:="java -jar /MailSender_fat.jar"

Case of 
	: (Count parameters:C259=0)
		$email:="tiran@mac.com"
		$subject:="hello"
		$body:="this is just a test"
		
	Else 
		$email:=$1
		$subject:=$2
		$body:=$3
		
End case 

$input:=""
$output:=""
$error:=""

//LAUNCH EXTERNAL PROCESS("java -jar MailSender_fat.jar tiran@me.com salam bodygoeshere")
LAUNCH EXTERNAL PROCESS:C811($command+" "+$email+" "+Quotify($subject)+" "+Quotify($body); $input; $output; $error)

$0:=$error