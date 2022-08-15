//RELATE MANY([Users]UserID)

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	relateMany(->[Privileges:24]; ->[Privileges:24]UserID:1; ->[Users:25]UserID:1)
End if 
