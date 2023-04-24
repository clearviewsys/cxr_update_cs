//%attributes = {}
C_BOOLEAN:C305($0)
C_TEXT:C284($1; $serverURL)
C_TEXT:C284($2; $username)
C_TEXT:C284($3; $password)

ASSERT:C1129(Count parameters:C259>2; "Not enough parameters")

$serverURL:=$1
$username:=$2
$password:=$3
$0:=False:C215

C_BOOLEAN:C305(ldapError)  // used in error handler

ON ERR CALL:C155("LDAP_ErrorHandler")

LDAP LOGIN:C1326($serverURL; $username; $password)

If (Not:C34(ldapError))
	$0:=True:C214
End if 

ON ERR CALL:C155("")
