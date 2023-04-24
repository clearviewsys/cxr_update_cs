//%attributes = {"publishedWeb":true}
C_TEXT:C284(webContextID)

If (webisContextAlive(webContextID))
	WEB SEND FILE:C619("changePasswordConfirmation.html")
Else 
	web_SendContextExpiredPage
End if 