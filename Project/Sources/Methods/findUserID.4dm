//%attributes = {}
#DECLARE($username : Text)->$userID : Integer

var $idx : Integer

ARRAY TEXT:C222($accountNames; 0)
ARRAY INTEGER:C220($accoutNumbers; 0)

GET USER LIST:C609($accountNames; $accoutNumbers)

$idx:=Find in array:C230($accountNames; $username)

If ($idx#-1)
	$userID:=$accoutNumbers{$idx}
Else 
	$userID:=$idx
End if 
