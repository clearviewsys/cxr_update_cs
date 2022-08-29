//%attributes = {}
C_TEXT:C284(webLoginID)

If (webisContextAlive(webContextID))  // this loads the login ID
	
	QUERY SELECTION:C341([eWires:13]; [eWires:13]AgentID:26=webLoginID)
	orderByeWires
	
	web_SendHTMLPage(->[eWires:13]; "List"; "*")
Else 
	web_SendContextExpiredPage
End if 