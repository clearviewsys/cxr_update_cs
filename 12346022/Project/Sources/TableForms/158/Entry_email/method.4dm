C_TEXT:C284($tFilePath)

handleViewFormMethod

If (Form event code:C388=On Load:K2:1)
	C_TEXT:C284(tNotificationType; tNotificationStatus)
	ARRAY TEXT:C222(atAttachments; 0)
	
	tNotificationType:=getNotificationTypeString(Form:C1466.type)
	tNotificationStatus:=getNotificationsStatus(Form:C1466.status)
	
	If (Form:C1466.message.attachments#Null:C1517)
		COLLECTION TO ARRAY:C1562(Form:C1466.message.attachments; atAttachments)
	End if 
	
	Case of 
		: (tNotificationType="Email")
			$tFilePath:=getEmailTemplateFolder+"bookings-confirmation.html"
			WA SET PAGE CONTENT:C1037(webArea; Form:C1466.message.message; $tFilePath)
			FORM GOTO PAGE:C247(1)
		: (tNotificationType="SMS")
			FORM GOTO PAGE:C247(2)
	End case 
End if 