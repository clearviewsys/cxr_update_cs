//%attributes = {}
// webSendRecordChangeEmail
//alerts INTERNAL cxr users to record changes

C_POINTER:C301($1; $ptrTable)

C_TEXT:C284($email; $template; $2; $purpose; $subject)
C_LONGINT:C283($i)


$ptrTable:=$1

If (Count parameters:C259>=2)
	$purpose:=$2
Else 
	$purpose:=""
End if 

$email:=getKeyValue("web.configuration.notification.email")

ARRAY TEXT:C222($atEmail; 0)
STR_SplitToArray($email; ","; ->$atEmail)

initEmailVars($ptrTable)  //process vars that can be used in the email template

Case of 
	: ($purpose="notificationReminder")  // webewire notification reminder
		
		For ($i; 1; Size of array:C274($atEmail))
			$email:=$atEmail{$i}
			If ($email="")
			Else 
				$template:="alert-new-record.html"
				sendNotificationByEmail($email; "[INTERNAL] Pending Action "+Table name:C256($ptrTable); getEmailTemplateBody($template; $ptrTable))
			End if 
		End for 
		
	: (Is new record:C668($ptrTable->))
		
		If (getKeyValue("web."+Table name:C256($ptrTable)+".save.new.alert")="true")
			For ($i; 1; Size of array:C274($atEmail))
				$email:=$atEmail{$i}
				If ($email="")
				Else 
					$template:="alert-new-record.html"
					sendNotificationByEmail($email; "[INTERNAL] A new record has been created for: ["+Table name:C256($ptrTable)+"]"; getEmailTemplateBody($template))  //UTIL_recordToText (Table($ptrTable)))
				End if 
			End for 
		End if 
		
	Else 
		//existing record
		
		If (getKeyValue("web."+Table name:C256($ptrTable)+".save.existing.alert")="true")
			For ($i; 1; Size of array:C274($atEmail))
				$email:=$atEmail{$i}
				If ($email="")
				Else 
					//$template:=Table name($ptrTable)+"-record-modified.html"
					If ($subject="")
						$subject:="[INTERNAL] A  record has been updated for: ["+Table name:C256($ptrTable)+"]"
					End if 
					$template:="alert-update-record.html"
					sendNotificationByEmail($email; $subject; getEmailTemplateBody($template))  //UTIL_recordToText (Table($ptrTable)))
				End if 
			End for 
		End if 
		
End case 


initEmailVars