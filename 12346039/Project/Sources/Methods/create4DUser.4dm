//%attributes = {}
// creates a user in 4D user system

C_TEXT:C284($1; $username)
C_TEXT:C284($2; $password)
C_TEXT:C284($3; $startupMethod)
C_LONGINT:C283($0; $userID)

$username:=$1
$password:=$2

If (Count parameters:C259>2)
	$startupMethod:=$3
Else 
	$startupMethod:=""
End if 

$userID:=getSystemUserID($username)

If ($userID=0)
	$userID:=Set user properties:C612(-1; $username; $startupMethod; $password; 0; !00-00-00!)  // number of logins and lastlogin ignored in project database
End if 

$0:=$userID
