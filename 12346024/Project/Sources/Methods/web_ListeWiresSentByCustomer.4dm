//%attributes = {"publishedWeb":true}
// eWiresList

C_TEXT:C284(webTitle)
C_TEXT:C284(webBody)

If (webisContextAlive(webContextID))  // this loads the login ID
	selecteWiresSentByCustomer(webLoginID)
	orderByeWires
	web_SendHTMLPage(->[eWires:13]; "List"; "*")
Else 
	web_SendContextExpiredPage
End if 
