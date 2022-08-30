//%attributes = {"publishedWeb":true}
// SendViaAuthentication

// $1: URL for a 4D command

// eg : SendViaAuthentication/SendMembersPage


// This procedure must be called from an HTML Link


C_TEXT:C284($1; webPostMethod)

If ($1#"")
	webPostMethod:=Substring:C12($1; 2)
	web_SendHTMLPage(->[WebUsers:14]; "Authenticate")
Else 
	web_SendHTMLPage(->[WebUsers:14]; "Authenticate")
End if 
