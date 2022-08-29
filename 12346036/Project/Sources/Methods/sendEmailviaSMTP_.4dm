//%attributes = {}
// sendEmailviaSMTP_
// use to embedded the image in the email body

C_OBJECT:C1216($1; $optionsObj)
C_TEXT:C284($mainContentType; $attachment; $fileName)
C_LONGINT:C283($0; $error; $smtpID; $errorClear)
C_COLLECTION:C1488($attachmentsCollection)

ASSERT:C1129(Count parameters:C259>0)

$optionsObj:=$1

ASSERT:C1129($optionsObj.MAIL_FROM#Null:C1517)
ASSERT:C1129($optionsObj.MAIL_RCPT#Null:C1517)
ASSERT:C1129($optionsObj.SUBJECT#Null:C1517)
ASSERT:C1129($optionsObj.URL#Null:C1517)
ASSERT:C1129($optionsObj.PORT#Null:C1517)

If ($optionsObj.URL="")
	$optionsObj.URL:="smtp://"+<>smtpServer
	$optionsObj.USERNAME:=<>smtpUserName
	$optionsObj.MAIL_FROM:=<>smtpFromEmail
	$optionsObj.PASSWORD:=<>smtpPassword
	$optionsObj.PORT:=<>smtpPortNo
End if 

If ($optionsObj.ATTACHMENTS#Null:C1517)
	$attachmentsCollection:=$optionsObj.ATTACHMENTS
End if 

$mainContentType:="text/plain"

If ($optionsObj.BODY#Null:C1517)
	If (Position:C15("<HTML"; Uppercase:C13($optionsObj.BODY); 1)>0)
		$mainContentType:="text/html"
	End if 
End if 

$error:=SMTP_New($smtpID)
If ($error=0)
	$error:=IT_SetPort(2; $optionsObj.PORT)
End if 
If ($error=0)
	$error:=SMTP_Host($smtpID; <>smtpServer)
End if 
If ($error=0)
	$error:=SMTP_Auth($smtpID; $optionsObj.USERNAME; $optionsObj.PASSWORD)
End if 
If ($error=0)
	$error:=SMTP_From($smtpID; $optionsObj.MAIL_FROM)
End if 
If ($error=0)
	$error:=SMTP_Sender($smtpID; $optionsObj.MAIL_FROM)
End if 
If ($error=0)
	$error:=SMTP_Subject($smtpID; $optionsObj.SUBJECT)
End if 
If ($error=0)
	$error:=SMTP_To($smtpID; $optionsObj.MAIL_RCPT; 0)
End if 
If ($error=0)
	If ($mainContentType="@html@")
		$error:=SMTP_Body($smtpID; $optionsObj.BODY; 4)
	Else 
		$error:=SMTP_Body($smtpID; $optionsObj.BODY; 1)
	End if 
End if 
If ($error=0)
	$error:=SMTP_SetPrefs(0; 1; 0)  // Added to prevent the email from putting the message inside a DAT file email attachment.
End if 
If ($error=0)
	For each ($attachment; $attachmentsCollection) Until ($error#0)
		$fileName:=getFileName($attachment)
		$error:=SMTP_Attachment($smtpID; $attachment; 2; 0; "Embedded"+$fileName)
	End for each 
End if 
If ($error=0)
	$error:=SMTP_Send($smtpID)
	$errorClear:=SMTP_Clear($smtpID)
End if 
$0:=$error
