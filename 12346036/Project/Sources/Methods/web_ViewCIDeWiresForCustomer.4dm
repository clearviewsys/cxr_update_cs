//%attributes = {"publishedWeb":true}
// webViewCIDeWires ( GETURLString)
// GETURLString is being sent from the browser 

C_TEXT:C284($1; $urlString)
C_TEXT:C284(searchKey; webContextID)
$urlString:=$1

web_ParseURL($urlString; ->webContextID; ->searchKey)

If ((webisContextAlive(webContextID)) & (([eWires:13]AgentID:26#webLoginID)))
	QUERY:C277([eWires:13]; [eWires:13]eWireID:1=searchKey)
	
	RELATE ONE:C42([eWires:13]LinkID:8)
	If (([Links:17]CustomerID:14#webLoginID) & ([eWires:13]AgentID:26#webLoginID))  // ******SECURITY CHECK VERY IMPORTANT
		selectNone(->[eWires:13])
	End if 
	
	SetVariablesToFields(->[eWires:13])
	
	// select the bank account that this user has access to
	QUERY:C277([Accounts:9]; [Accounts:9]AgentID:16=webLoginID)
	
	If ([eWires:13]isPaymentSent:20=True:C214)
		QUERY SELECTION:C341([Accounts:9]; [Accounts:9]Currency:6=webToCurrency)
	Else 
		QUERY SELECTION:C341([Accounts:9]; [Accounts:9]Currency:6=webFromCurrency)
	End if 
	
	HTMLSelectionToMenu("webForeignAccount"; ->[Accounts:9]; ->[Accounts:9]AccountID:1; ->[Accounts:9]AccountID:1)
	web_SendHTMLPage(->[eWires:13]; "ViewForCustomer"; "CID")
Else 
	web_SendContextExpiredPage
End if 