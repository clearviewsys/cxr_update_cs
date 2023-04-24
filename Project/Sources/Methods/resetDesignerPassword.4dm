//%attributes = {}
C_DATE:C307($lastLogin)
C_TEXT:C284($name; $startup; $password)
C_LONGINT:C283($nbLogin; $groupOwner; $ret; $newUserID)

If (<>USERID="1")
	
	ARRAY TEXT:C222($accountNames; 0)
	ARRAY INTEGER:C220($accoutNumbers; 0)
	ARRAY LONGINT:C221($memberships; 0)
	
	GET USER LIST:C609($accountNames; $accoutNumbers)
	GET USER PROPERTIES:C611(1; $name; $startup; $password; $nbLogin; $lastLogin; $memberships; $groupOwner)
	$password:=""  // enter Designer password here and run method, then delete the password
	$newUserID:=Set user properties:C612(1; $name; $startup; $password; $nbLogin; $lastLogin; $memberships; $groupOwner)
End if 
