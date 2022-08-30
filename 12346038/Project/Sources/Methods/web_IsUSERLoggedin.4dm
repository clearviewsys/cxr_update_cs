//%attributes = {"publishedWeb":true}
// webIsUSERLoggedin (loginID) -> boolean

// look for user in the ACTIVE_USERS and select the user in the USERS table
// returns true if user is logged in


C_BOOLEAN:C305($0)

C_TEXT:C284($1)

QUERY:C277([WebSessions:15]; [WebSessions:15]webUsername:2=$1)
If (Records in selection:C76([WebSessions:15])=1)
	$0:=True:C214
Else 
	$0:=False:C215
End if 