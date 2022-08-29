//%attributes = {"publishedWeb":true}
C_TEXT:C284(webLoginID; webContextID)
If (webisContextAlive(webContextID))
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=webLoginID)
	web_SendHTMLPage(->[Customers:3]; "View")
Else 
	web_SendContextExpiredPage
End if 