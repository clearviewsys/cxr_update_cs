//%attributes = {"publishedWeb":true}
If (webisContextAlive(webContextID))  // load the webloginID
	
	QUERY:C277([WebUsers:14]; [WebUsers:14]webUsername:1=webLoginID)
End if 
web_SendHTMLPage(->[Links:17]; "Entry"; "*")