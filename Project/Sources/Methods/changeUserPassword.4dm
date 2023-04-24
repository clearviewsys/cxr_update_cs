//%attributes = {"shared":true}
//  changeUserPassword 
// this method will allow users to modify their password

C_TEXT:C284($newPassword; $currentUser)
$currentUser:=Current user:C182
$newPassword:=requestChangePassword("admin")
If (Current user:C182#vUserName)
	myAlert("Please log into this account before changing the password")
Else 
	If ($newPassword#"")  // actually change the user's password
		//CHANGE PASSWORD($newPassword)
		// changePassword($newPassword)
		changePasswordForUser(vUserName; $newPassword)
		myAlert("Password changed successfuly!")
	End if 
End if 

<>SystemUser:=Current user:C182
<>ApplicationUser:=Current user:C182
<>UserID:=String:C10(getSystemUserID(Current user:C182))

