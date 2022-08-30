//%attributes = {}
// webSendUserAreaPage
C_LONGINT:C283(webeWireInboxCount; webeWireOutboxCount; webeMessageInboxCount; webeMessageOutboxCount)
C_LONGINT:C283(webeWireCount; webeMessageCount; webLinkCount)

If (webisContextAlive(webContextID))
	QUERY:C277([WebUsers:14]; [WebUsers:14]webUsername:1=webLoginID)
	If ([WebUsers:14]relatedTable:8>0)  // added >0 as there was a compiler error #TB
		webemessageInboxCount:=counteMessageInboxForAgent(webLoginID)
		webeMessageOutboxCount:=counteMessageOutboxForAgent(webLoginID)
		webeWireInboxCount:=counteWiresReceivedByCustomer(webLoginID)
		webeWireOutboxCount:=counteWiresSentByCustomer(webLoginID)
		
		web_SendHTMLPage(->[WebUsers:14]; "CustomerPanel")  // TERMINAL STATEMENT 
	Else 
		webeWireInboxCount:=counteWireInboxForAgent(webLoginID)
		webeWireOutboxCount:=counteWireOutboxForAgent(webLoginID)
		webemessageInboxCount:=counteMessageInboxForAgent(webLoginID)
		webeMessageOutboxCount:=counteMessageOutboxForAgent(webLoginID)
		webeWireCount:=counteWireCountForAgent(webLoginID)
		webeMessageCount:=counteMessageForAgent(webLoginID)
		webLinkCount:=countLinksForAgent(webLoginID)
		
		web_SendHTMLPage(->[WebUsers:14]; "Panel")  // TERMINAL STATEMENT 
	End if 
Else 
	web_SendContextExpiredPage
End if 