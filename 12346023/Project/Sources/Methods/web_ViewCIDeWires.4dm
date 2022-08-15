//%attributes = {"publishedWeb":true}
// webViewCIDeWires ( GETURLString)
// GETURLString is being sent from the browser 

C_TEXT:C284($1)

//webViewCID (->[eWires];$1;->[eWires]LinkID)
C_TEXT:C284(searchKey; webContextID)

web_ParseURL($1; ->webContextID; ->searchKey)
//GOTO RECORD($1->;Num(searchKey))




If (webisContextAlive(webContextID))
	QUERY:C277([eWires:13]; [eWires:13]eWireID:1=searchKey)
	RELATE ONE:C42([eWires:13]LinkID:8)
	
	If (([Links:17]CustomerID:14#webLoginID) & ([eWires:13]AgentID:26#webLoginID))  // ******SECURITY CHECK VERY IMPORTANT
		selectNone(->[eWires:13])
	End if 
	If (Records in selection:C76([eWires:13])#0)
		SetVariablesToFields(->[eWires:13])
		
		// select the bank account that this user has access to
		QUERY:C277([Accounts:9]; [Accounts:9]AgentID:16=webLoginID)
		
		If ([eWires:13]isPaymentSent:20=True:C214)
			QUERY SELECTION:C341([Accounts:9]; [Accounts:9]Currency:6=webToCurrency)
		Else 
			QUERY SELECTION:C341([Accounts:9]; [Accounts:9]Currency:6=webFromCurrency)
		End if 
		QUERY SELECTION:C341([Accounts:9]; [Accounts:9]isBankAccount:7=True:C214)
		
		HTMLSelectionToMenu("webForeignAccount"; ->[Accounts:9]; ->[Accounts:9]AccountID:1; ->[Accounts:9]AccountID:1)
		web_SendHTMLPage(->[eWires:13]; "View"; "CID")
	Else 
		web_SendErrorMsg("No records to display. (You may not be authorized to view this record)")
	End if 
Else 
	web_SendContextExpiredPage
End if 