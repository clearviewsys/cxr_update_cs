//%attributes = {}
// sendHTMLPAGE( {*})

// pageType may be { list, view, modify, entry, search, etc...")

// if you send an optional * (or any other character) context validity will be checked



C_TEXT:C284($1)

If (Count parameters:C259=1)  // check for contect aliveness
	
	If (webisContextAlive(webContextID))
		WEB SEND FILE:C619("TableList.html")
	Else 
		web_SendContextExpiredPage
	End if 
Else 
	WEB SEND FILE:C619("TableList.html")
End if 