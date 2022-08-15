//%attributes = {}
C_TEXT:C284(webLoginID)

If (webisContextAlive(webContextID))  // this loads the login ID
	QUERY SELECTION:C341([Registers:10]; [Registers:10]CustomerID:5=webLoginID)
	orderByRegisters
	web_SendHTMLPage(->[Registers:10]; "List"; "*")
Else 
	web_SendContextExpiredPage
End if 