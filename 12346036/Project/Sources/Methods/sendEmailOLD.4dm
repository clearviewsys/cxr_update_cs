//%attributes = {"publishedWeb":true}

// sendEmail (to; subject;body ; {host; fromEmail};{accountname;password;port})
// send email using Tiran's personal smtp2go account

C_LONGINT:C283($vError; $0)
C_LONGINT:C283($vSmtp_id)
C_TEXT:C284($1; $2; $3; $toEmail; $subject; $body)
C_TEXT:C284($4; $5; $6; $7; $smtpHost; $smtpFromEmail; $smtpUserName; $smtpPassword)
C_LONGINT:C283($8; $smtpPort)

//loadServerPreferences 
//assignServerPrefsVarsToFields 

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


$vError:=0
$vError:=$vError+IT_SetTimeOut(10)
$vError:=$vError+IT_SetPort(2; $smtpPort)  // the first parameter 2 is for protocol SMTP (1; ftp: 3; pop; 4: imap)

$vError:=$vError+SMTP_New($vSmtp_id)
$vError:=$vError+SMTP_Host($vSmtp_id; $smtpHost)
$vError:=$vError+SMTP_From($vSmtp_id; $smtpFromEmail)
$vError:=$vError+SMTP_Subject($vSmtp_id; $subject)
$vError:=$vError+SMTP_To($vSmtp_id; $toEmail)


If (Position:C15("<HTML"; Uppercase:C13($body); 1)>0)
	$vError:=SMTP_AddHeader($vSmtp_id; "Content-Type:"; "text/html;charset=us-ascii"; 1)
End if 

$vError:=$vError+SMTP_Body($vSmtp_id; $body)


// The fields are entered if the server uses an authentication
// mechanism. Otherwise, null strings are returned.

$vError:=$vError+SMTP_Auth($vSmtp_id; $smtpUserName; $smtpPassword; 2)
$vError:=$vError+SMTP_Send($vSmtp_id)
$vError:=$vError+SMTP_Clear($vSmtp_id)

//$vError:=SMTP_QuickSend ($smtpHost;$smtpFromEmail;$toEmail;$subject;$body)
If ($vError#0) & (Application type:C494#4D Server:K5:6)
	myAlert("Error: "+Char:C90(13)+IT_ErrorText($vError))
End if 
$0:=$vError
