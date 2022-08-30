//%attributes = {}
C_TEXT:C284($command; $input; $output; $error; $email; $subject; $body)

$command:="java -jar /MailSender_fat.jar "
$email:="tiran@me.com "
$subject:="Subjectline "
$body:="body"
$input:=""
$output:=""
$error:=""


//LAUNCH EXTERNAL PROCESS("java -jar MailSender_fat.jar tiran@me.com salam bodygoeshere")
LAUNCH EXTERNAL PROCESS:C811($command+$email+$subject+$body; $input; $output; $error)
myAlert($output+$error)