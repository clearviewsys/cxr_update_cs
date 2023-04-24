//%attributes = {}
C_TEXT:C284(webLoginID)

If (webisContextAlive(webContextID))  // this loads the login ID
	
	QUERY SELECTION:C341([Invoices:5]; [Invoices:5]CustomerID:2=webLoginID)
	//QUERY([Invoices];[Invoices]CustomerID="tirbeh17")
	orderByInvoices
	
	web_SendHTMLPage(->[Invoices:5]; "List"; "*")
Else 
	web_SendContextExpiredPage
End if 