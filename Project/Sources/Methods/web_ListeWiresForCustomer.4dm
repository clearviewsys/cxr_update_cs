//%attributes = {"publishedWeb":true}
C_TEXT:C284(webLoginID; webContextID)
If (webisContextAlive(webContextID))
	QUERY:C277([eWires:13]; [eWires:13]CustomerID:15=webLoginID)
	orderByeWires
	web_SendHTMLPage(->[eWires:13]; "ListForCustomer"; "*")
Else 
	web_SendContextExpiredPage
End if 