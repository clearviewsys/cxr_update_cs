//%attributes = {}

If (<>USERID="1")
	ARRAY TEXT:C222($accountNames; 0)
	ARRAY INTEGER:C220($accoutNumbers; 0)
	C_TEXT:C284($name; $startup; $password)
	C_LONGINT:C283($nbLogin; $groupOwner; $ret)
	ARRAY LONGINT:C221($memberships; 0)
	C_DATE:C307($lastLogin)
	GET USER LIST:C609($accountNames; $accoutNumbers)
	GET USER PROPERTIES:C611(2; $name; $startup; $password; $nbLogin; $lastLogin; $memberships; $groupOwner)
	$password:="admin1234!"
	Set user properties:C612(2; $name; $startup; $password; $nbLogin; $lastLogin; $memberships; $groupOwner)
End if 
