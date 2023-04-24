//%attributes = {"publishedWeb":true}

C_TEXT:C284($1)

C_TEXT:C284(searchKey; webContextID)
web_ParseURL($1; ->webContextID; ->searchKey)

QUERY:C277([Registers:10]; [Registers:10]InvoiceNumber:10=searchKey)

SetVariablesToFields(->[Registers:10])

If (webisContextAlive(webContextID))
	QUERY SELECTION:C341([Registers:10]; [Registers:10]CustomerID:5=webLoginID)  // filter only the register for the right customer
	If (Records in selection:C76([Registers:10])=0)
		web_SendErrorMsg("Access denied to invoice"+searchKey)
	Else 
		WEB SEND FILE:C619("RegistersList.html")
	End if 
Else 
	web_SendContextExpiredPage
End if 