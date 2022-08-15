//%attributes = {}
// isUserSuperAdmin ->boolean
// returns true if user is designer or administrator
// this is only true if the user is a 4D admin (not an application level admin)


C_BOOLEAN:C305($0)

If ((User in group:C338(getApplicationUser; "Administrators")) | (User in group:C338(getApplicationUser; "Designers")))
	$0:=True:C214
Else 
	$0:=False:C215
End if 