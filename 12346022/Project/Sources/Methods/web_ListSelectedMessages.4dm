//%attributes = {}
C_TEXT:C284(webLoginID)

If (webisContextAlive(webContextID))  // this loads the login ID
	
	QUERY SELECTION:C341([MESSAGES:11]; [MESSAGES:11]toUserID:6=webLoginID; *)
	QUERY SELECTION:C341([MESSAGES:11];  | ; [MESSAGES:11]FromUserID:5=webLoginID; *)
	QUERY SELECTION:C341([MESSAGES:11];  | ; [MESSAGES:11]toUserID:6="")
	orderMessages
	web_SendHTMLPage(->[MESSAGES:11]; "List"; "*")
Else 
	web_SendContextExpiredPage
End if 