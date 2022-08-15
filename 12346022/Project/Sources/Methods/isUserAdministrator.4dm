//%attributes = {}
// isUserAdministrator ->boolean
// returns true if user is designer or administrator

C_BOOLEAN:C305($0)

If ((isUserAllowedTo(->[Users:25]isAdministrator:33)) | (User in group:C338(getApplicationUser; "Administrators"))\
 | (User in group:C338(getApplicationUser; "Designers")) | (getApplicationUser="designer"))
	$0:=True:C214
Else 
	$0:=False:C215
End if 

//isUserManager