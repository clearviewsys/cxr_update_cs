//%attributes = {}
//  changeAdminUserPassword 
// this method will allow admins to modify their password

C_TEXT:C284($newPassword; $currentUser; $currentUserName)
$currentUserName:=vUserName
vUserName:="Administrator"
If (Current user:C182#vUserName)
	myAlert("Please log into this account before changing the password")
Else 
	
	$currentUser:=Current user:C182
	$newPassword:=requestChangePassword("admin")
	
	If ($newPassword#"")  // actually change the user's password
		//CHANGE PASSWORD($newPassword)
		changePassword($newPassword)
		myAlert("Password changed successfuly!")
	End if 
End if 
vUserName:=$currentUserName

<>SystemUser:=Current user:C182
<>ApplicationUser:=Current user:C182
<>UserID:=String:C10(getSystemUserID(Current user:C182))