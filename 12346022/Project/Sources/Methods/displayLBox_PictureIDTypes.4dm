//%attributes = {"shared":true}
If (isUserAdministrator)
	displayLBox_(->[PictureIDTypes:92])
Else 
	myAlert_AdminPrivilegeNeeded
End if 
