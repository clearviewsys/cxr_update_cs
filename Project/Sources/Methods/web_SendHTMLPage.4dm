//%attributes = {"publishedWeb":true}
// sendHTMLPAGE( ->table; pageType; {*})
// pageType may be { list, view, modify, entry, search, etc...")
// if you send an optional * (or any other character) context validity will be checked


C_POINTER:C301($1)
C_TEXT:C284($2; $3)

If (Count parameters:C259=3)  // check for contect aliveness
	If (webisContextAlive(webContextID))
		WEB SEND FILE:C619(Table name:C256($1)+$2+".html")
	Else 
		web_SendContextExpiredPage
	End if 
Else 
	WEB SEND FILE:C619(Table name:C256($1)+$2+".html")
End if 