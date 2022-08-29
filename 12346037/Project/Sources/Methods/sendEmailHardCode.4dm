//%attributes = {}
C_TEXT:C284($1; $2; $3; $toEmail; $subject; $body)
C_TEXT:C284($4; $5; $6; $7; $smtpHost; $smtpFromEmail; $smtpUserName; $smtpPassword)
C_LONGINT:C283($8; $smtpPort; $vError; $0)
C_OBJECT:C1216($options)

$toEmail:="support@clearviewsys.com"
$subject:="Automated test email sent from CurrencyXchanger"
$body:="This is the test email body message"+CRLF+"Send from "+<>companyName+" "+getCurrentMachineName

$smtpHost:="mail.4d.rs"
$smtpFromEmail:="info@4d.rs"
$smtpUserName:="info@4d.rs"
$smtpPassword:="Sr11Ma26"
$smtpPort:=587

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
	: (Count parameters:C259=5)
		$toEmail:=$1
		$subject:=$2
		$body:=$3
		$smtpHost:=$4
		$smtpFromEmail:=$5
		
	: (Count parameters:C259=8)
		$toEmail:=$1
		$subject:=$2
		$body:=$3
		$smtpHost:=$4
		$smtpFromEmail:=$5
		$smtpUserName:=$6
		$smtpPassword:=$7
		$smtpPort:=$8
		
		
	: (Count parameters:C259=9)
		$toEmail:=$1
		$subject:=$2
		$body:=$3
		$smtpHost:=$4
		$smtpFromEmail:=$5
		$smtpUserName:=$6
		$smtpPassword:=$7
		$smtpPort:=$8
		
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

$vError:=sendEmailviacURL($options)

If ($vError#0) & (Application type:C494#4D Server:K5:6)
	notifyAlert("Email Error"; "Error sending email ["+String:C10($vError)+"]"+CRLF+$subject; 5)
End if 

$0:=$vError
