//%attributes = {}
// sendEmail(to; subject ; body) ->errorCode
C_LONGINT:C283($vError; $0)
C_TEXT:C284($1; $2; $3; $toEmail; $subject; $body; $header; $signature)
C_COLLECTION:C1488($4; $attachments)
C_OBJECT:C1216($options)
C_TEXT:C284(<>smtpServer; <>smtpUserName; <>smtpFromEmail; <>smtpPassword)
C_LONGINT:C283(<>smtpPortNo)

$toEmail:=$1
$subject:=$2
$body:=$3


If (Count parameters:C259>=4)
	$attachments:=$4
End if 

If ($attachments.length=0)
	$vError:=sendEmail($toEmail; $subject; $body; <>smtpServer; <>smtpFromEmail; <>smtpUserName; <>smtpPassword; <>smtpPortNo)
Else 
	$options:=New object:C1471
	
	$options.URL:="smtp://"+<>SMTPSERVER
	$options.PORT:=<>SMTPPORTNO
	$options.USERNAME:=<>SMTPUSERNAME
	$options.PASSWORD:=<>SMTPPASSWORD
	$options.MAIL_FROM:=<>SMTPFROMEMAIL
	$options.MAIL_RCPT:=$toEmail
	$options.BODY:=$body
	$options.SUBJECT:=$subject
	
	$vError:=sendEmailviacURL($options; $attachments)
End if 


$0:=$vError