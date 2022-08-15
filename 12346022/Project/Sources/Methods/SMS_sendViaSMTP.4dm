//%attributes = {}
//SMS_sendViaSMTP (phone; message;replyEmail)
// this method uses the SMTP protocal to send an SMS message via clickatell network

C_TEXT:C284($body; $message; $phone; $replyEmail; $1; $2; $3)

Case of 
	: (Count parameters:C259=1)
		$phone:=$1
		$message:="Test"
		$replyEmail:=""
		
	: (Count parameters:C259=2)
		$phone:=$1
		$message:=$2
		$replyEmail:=""
		
	: (Count parameters:C259=3)
		$phone:=$1
		$message:=$2
		$replyEmail:=$3
		
	Else 
		$phone:="+642108731968"
		$message:="test SMS"
		$replyEmail:="tiran@clearviewsys.com"
		
End case 
appendLabelString(->$body; "api_id:"; String:C10(<>clickatellSMTP_API_ID); True:C214)
appendLabelString(->$body; "user:"; <>clickatellUsername; True:C214)
appendLabelString(->$body; "password:"; <>clickatellPassword; True:C214)
appendLabelString(->$body; "to:"; $phone; True:C214)

If ($replyEmail#"")
	appendLabelString(->$body; "reply:"; <>ADMINISTRATOREMAIL; True:C214)
End if 

appendLabelString(->$body; "text:"; $message; True:C214)


C_LONGINT:C283($error)
$error:=sendEmail("sms@messaging.clickatell.com"; ""; $body)

If ($error#0)
	myAlert("There was an error sending the message via SMTP API")
Else 
	myAlert($body)
End if 