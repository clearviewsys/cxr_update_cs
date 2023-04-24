//%attributes = {}
C_TEXT:C284($name; $startup; $password)
C_LONGINT:C283($nbLogin; $groupOwner; $ret; $newUserID; $idx)
C_DATE:C307($lastLogin)

ARRAY TEXT:C222($accountNames; 0)
ARRAY INTEGER:C220($accoutNumbers; 0)
ARRAY LONGINT:C221($memberships; 0)

GET USER LIST:C609($accountNames; $accoutNumbers)

$idx:=Find in array:C230($accountNames; "Support")


If ($idx#-1)
	GET USER PROPERTIES:C611($idx; $name; $startup; $password; $nbLogin; $lastLogin; $memberships; $groupOwner)
End if 

$password:="cxrhelp911@CVS.com"
$newUserID:=Set user properties:C612($idx; "Support"; $startup; $password; $nbLogin; $lastLogin; $memberships; $groupOwner)
