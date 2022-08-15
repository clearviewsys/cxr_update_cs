//%attributes = {}
// Authenticates User against LDAP server defined in ServerPrefs

C_BOOLEAN:C305($0)
C_TEXT:C284($1; $username)
C_TEXT:C284($2; $password)
C_TEXT:C284($serverURL)

ASSERT:C1129(Count parameters:C259>1; "Not enough parameters")

$username:=$1
$password:=$2
$0:=False:C215

$serverURL:=LDAP_GetServerURL

If ($serverURL#"")
	
	If (LDAP_Login($serverURL; $username; $password))
		$0:=True:C214
		LDAP LOGOUT:C1327
	End if 
	
End if 
