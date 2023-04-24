//%attributes = {}

// ----------------------------------------------------
// User name (OS): Milan
// Date and time: 11/20/19, 09:35:29
// ----------------------------------------------------
// Method: sendEmaliviacURL (option; 
// Description
// 
// sends email using cURL plugin by Miyako
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($1; $optionsObj; $attachmentPathObj)
C_COLLECTION:C1488($2; $attachmentsCollection)
C_BLOB:C604($Request; $Response; $attachment_x)
C_TEXT:C284($body; $TransferInfo; $HeaderInfo; $boundary; $attachment_t; $bodyheader; $domain; $bodyTxtPart; $contentTypePart)
C_TEXT:C284($attachmentPart; $attachmentPath; $attachmentContentType; $attachmentcontentdisposition; $mainContentType)
C_LONGINT:C283($0; $err)

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

If (Count parameters:C259>1)
	$attachmentsCollection:=$2
End if 

$optionsObj.USE_SSL:="USESSL_TRY"
$optionsObj.UPLOAD:=1
$optionsObj.SSL_VERIFYHOST:=0
$optionsObj.SSL_VERIFYPEER:=0

$boundary:="CXR_"+Generate UUID:C1066
$bodyTxtPart:=""
$attachmentPart:=""
$mainContentType:="text/plain"

If ($optionsObj.BODY#Null:C1517)
	If (Position:C15("<HTML"; Uppercase:C13($optionsObj.BODY); 1)>0)
		$mainContentType:="text/html"
	End if 
End if 

// get domain part of from we need it for message ID
$domain:=UTIL_GetDomainPartOfEmail($optionsObj.MAIL_FROM)  // it includes @ itself

// $contentTypePart:="Content-Type: "+$mainContentType+"; charset=utf-8\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n"

$contentTypePart:="Content-Type: "+$mainContentType+"; charset=utf-8\r\nContent-Transfer-Encoding: 8bit\r\n\r\n"

If ($attachmentsCollection#Null:C1517)
	
	If ($attachmentsCollection.length>0)
		
		$contentTypePart:="Content-Type: multipart/mixed; boundary="+Char:C90(Double quote:K15:41)+$boundary+Char:C90(Double quote:K15:41)+"\r\n\r\n"
		$bodyTxtPart:="--"+$boundary+"\r\nContent-Type: "+$mainContentType+"; charset=utf-8\r\nContent-Transfer-Encoding: 8bit\r\n\r\n"
		
		For each ($attachmentPath; $attachmentsCollection)
			
			$attachmentPathObj:=Path to object:C1547($attachmentPath)
			
			$attachmentContentType:=MIME_GetTypeByExtension($attachmentPathObj.extension)
			
			DOCUMENT TO BLOB:C525($attachmentPath; $attachment_x)
			BASE64 ENCODE:C895($attachment_x; $attachment_t)
			
			$attachmentPart:=$attachmentPart+"--"+$boundary+"\r\n"+\
				"Content-Disposition: attachment"+\
				"; filename="+Char:C90(Double quote:K15:41)+$attachmentPathObj.name+$attachmentPathObj.extension+Char:C90(Double quote:K15:41)+"\r\n"+\
				"Content-Type: "+$attachmentContentType+"; name="+Char:C90(Double quote:K15:41)+$attachmentPathObj.name+$attachmentPathObj.extension+Char:C90(Double quote:K15:41)+"\r\n"+\
				"Content-Transfer-Encoding: base64"+"\r\n\r\n"
			$attachmentPart:=$attachmentPart+$attachment_t+"\r\n\r\n"
			
		End for each 
		
	End if 
End if 

$bodyheader:="To: "+$optionsObj.MAIL_RCPT+"\r\n"+\
"From: "+$optionsObj.MAIL_FROM+"\r\n"+\
"Message-ID: <"+Generate UUID:C1066+$domain+">\r\n"+\
"Subject: "+$optionsObj.SUBJECT+"\r\n"+$contentTypePart

//If ($Options.BODY#Null)
//$bodyTxtPart:=$bodyTxtPart+UTIL_UTF8_to_quotedprintable ($Options.BODY)
//End if 

If ($optionsObj.BODY#Null:C1517)
	$bodyTxtPart:=$bodyTxtPart+$optionsObj.BODY
End if 

$body:=$bodyheader+"\r\n\r\n"+$bodyTxtPart+"\r\n\r\n"+$attachmentPart

TEXT TO BLOB:C554($body; $Request; UTF8 text without length:K22:17)

$err:=cURL(JSON Stringify:C1217($optionsObj); \
$Request; \
$Response; \
""; \
$TransferInfo; \
$HeaderInfo)

$0:=$err
