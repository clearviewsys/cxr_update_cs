//%attributes = {}
C_LONGINT:C283($err)
C_OBJECT:C1216($Options)

$Options:=New object:C1471

C_TEXT:C284(<>smtpServer; <>smtpUserName; <>smtpFromEmail; <>smtpPassword)
C_TEXT:C284($1; $2; $3; $toEmail; $subject; $body)

$toEmail:=$1
$subject:=$2
$body:=$3

$Options.URL:="smtp://"+<>smtpServer
$Options.PORT:=<>SMTPPORTNO
$Options.USERNAME:=<>SMTPUSERNAME
$Options.PASSWORD:=<>SMTPPASSWORD
$Options.MAIL_FROM:=<>SMTPFROMEMAIL
$Options.MAIL_RCPT:=$toEmail
$Options.BODY:=$body
$options.SUBJECT:=$subject

$err:=sendEmailviacURL($Options)


