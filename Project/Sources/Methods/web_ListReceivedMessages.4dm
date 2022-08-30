//%attributes = {"publishedWeb":true}
// because we need the webLoginID

If (webisContextAlive(webContextID))
	QUERY:C277([MESSAGES:11]; [MESSAGES:11]toUserID:6=""; *)
	QUERY:C277([MESSAGES:11];  | ; [MESSAGES:11]toUserID:6=webLoginID)
	QUERY SELECTION:C341([MESSAGES:11]; [MESSAGES:11]isUnlisted:13=False:C215)
	
	web_ListSelectedMessages
Else 
	web_SendContextExpiredPage
End if 