//%attributes = {"shared":true}
If (isUserAdministrator)
	displayLBox(->[PictureIDTypes:92])
Else 
	myAlert_AdminPrivilegeNeeded
End if 
