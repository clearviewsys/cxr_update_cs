//%attributes = {"publishedWeb":true}
If (webisContextAlive(webContextID))
	
	QUERY:C277([MESSAGES:11]; [MESSAGES:11]isUnlisted:13=False:C215; *)
	QUERY:C277([MESSAGES:11];  & ; [MESSAGES:11]FromUserID:5=webLoginID)
	web_ListSelectedMessages
Else 
	web_SendContextExpiredPage
End if 