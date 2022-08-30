//%attributes = {"publishedWeb":true}
C_TEXT:C284(webToCurrency; webFromCurrency)
C_REAL:C285(webFromAmountR; webToAmountR)
C_TEXT:C284(webFromAmount; webToAmount)
C_TEXT:C284(webLinkID; webFromName; webToName; webFromCurrency; webToCurrency)
C_TEXT:C284(webRate; webInverseRate)

If (webisContextAlive(webContextID))
	C_TEXT:C284(webSenderReceiver)
	
	//
	QUERY:C277([Links:17]; [Links:17]LinkID:1=webLinkID)
	RELATE ONE:C42([Links:17]CustomerID:14)
	webSenderReceiver:=[Links:17]FullName:4+" >> "+[Links:17]CustomerName:15
	//HTMLSelectionToList2 ("webLinkID";->[Links];->[Links]FullName;->[Links]CustomerName;->[Links]LinkID;" --> ")
	
	//populate the fromCurrency pulldown on the web form
	QUERY:C277([Accounts:9]; [Accounts:9]AgentID:16=getLoggedInUserID)  // select all accounts that are linked to this agent
	RELATE ONE SELECTION:C349([Accounts:9]; [Currencies:6])  // now only select the currencies that this agent can handle
	HTMLSelectionToMenu("webFromCurrency"; ->[Currencies:6]; ->[Currencies:6]CurrencyCode:1; ->[Currencies:6]CurrencyCode:1)
	
	// 
	QUERY:C277([Currencies:6]; [Currencies:6]isHiddenForEwire:30=False:C215)
	HTMLSelectionToMenu("webToCurrency"; ->[Currencies:6]; ->[Currencies:6]CurrencyCode:1; ->[Currencies:6]CurrencyCode:1)
	
	// Select the bank account that this user has access to
	QUERY:C277([Accounts:9]; [Accounts:9]AgentID:16=getLoggedInUserID)  // THIS METHOD IS CHANGED IN VERSION 3.523
	QUERY SELECTION:C341([Accounts:9]; [Accounts:9]isBankAccount:7=True:C214; *)
	QUERY SELECTION:C341([Accounts:9];  | ; [Accounts:9]isSettlementAccount:25=True:C214)  // any settlement account should work for that agent
	
	HTMLSelectionToMenu("webForeignAccount"; ->[Accounts:9]; ->[Accounts:9]AccountID:1; ->[Accounts:9]AccountID:1)
	
	
	web_SendHTMLPage(->[eWires:13]; "Entry"; "*")
	
Else 
	web_SendContextExpiredPage
End if 
