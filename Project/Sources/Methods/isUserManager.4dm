//%attributes = {}
// isUserManager( ) -> boolean

C_POINTER:C301($1)
C_BOOLEAN:C305($0)

If (isUserAdministrator)  // administrator is allowed anyway
	$0:=True:C214
Else 
	$0:=isUserAllowedTo(->[Users:25]isManager:10)  // the other users are allowed only 
End if 