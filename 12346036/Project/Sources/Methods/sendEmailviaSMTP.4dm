//%attributes = {}
//sendEmailviaSMTP

C_TEXT:C284($1; $2; $3; $toEmail; $subject; $body)
C_COLLECTION:C1488($4; $attachments)
C_TEXT:C284($5; $6; $7; $8; $smtpHost; $smtpFromEmail; $smtpUserName; $smtpPassword)
C_LONGINT:C283($9; $smtpPort; $vError; $0)
C_OBJECT:C1216($options)

$toEmail:="support@clearviewsys.com"
$subject:="Automated test email sent from CurrencyXchanger"
$body:="This is the test email body message"+CRLF+"Send from "+<>companyName+" "+getCurrentMachineName

$smtpHost:=<>SMTPSERVER
$smtpFromEmail:=<>SMTPFROMEMAIL
$smtpUserName:=<>SMTPUSERNAME
$smtpPassword:=<>SMTPPASSWORD
$smtpPort:=<>SMTPPORTNO

Case of 
	: (Count parameters:C259=1)
		$toEmail:=$1
	: (Count parameters:C259=2)
		$toEmail:=$1
		$subject:=$2
	: (Count parameters:C259=3)
		$toEmail:=$1
		$subject:=$2
		$body:=$3
	: (Count parameters:C259=4)
		$toEmail:=$1
		$subject:=$2
		$body:=$3
		$attachments:=$4
	: (Count parameters:C259=6)
		$toEmail:=$1
		$subject:=$2
		$body:=$3
		$attachments:=$4
		$smtpHost:=$5
		$smtpFromEmail:=$6
		
	: (Count parameters:C259=9)
		$toEmail:=$1
		$subject:=$2
		$body:=$3
		$attachments:=$4
		$smtpHost:=$5
		$smtpFromEmail:=$6
		$smtpUserName:=$7
		$smtpPassword:=$8
		$smtpPort:=$9
		
		
	: (Count parameters:C259=9)
		$toEmail:=$1
		$subject:=$2
		$body:=$3
		$attachments:=$4
		$smtpHost:=$5
		$smtpFromEmail:=$6
		$smtpUserName:=$7
		$smtpPassword:=$8
		$smtpPort:=$9
		
	Else 
End case 

$options:=New object:C1471

$options.URL:="smtp://"+$smtpHost
$options.PORT:=$smtpPort
$options.USERNAME:=$smtpUserName
$options.PASSWORD:=$smtpPassword
$options.MAIL_FROM:=$smtpFromEmail
$options.MAIL_RCPT:=$toEmail
$options.BODY:=$body
$options.SUBJECT:=$subject
$options.ATTACHMENTS:=$attachments

$vError:=sendEmailviaSMTP_($options)

If ($vError#0) & (Application type:C494#4D Server:K5:6)
	notifyAlert("Email error"; "Error sending email ["+String:C10($vError)+"]"+CRLF+$subject; 5)
End if 

$0:=$vError
