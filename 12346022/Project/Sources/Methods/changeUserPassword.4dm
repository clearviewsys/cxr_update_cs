//%attributes = {"shared":true}
//  changeUserPassword 
// this method will allow users to modify their password

//C_STRING(80;$password1;$password2)


//$password1:=Request("Please enter new password for "+Current user)
//If (OK=1)
//$password2:=Request("Please re-enter the password :")
//If ($password1=$password2)  `passwords did match
//CONFIRM("Are you sure you want to change your password permanently ?";"Yes";"No")
//If (OK=1)  ` confirmation for change of password approved
//CHANGE PASSWORD($password2)
//ALERT("Your password has been changed successfully!")
//Else 
//ALERT("As you requested, your password did NOT change !"+Char(13)+"Thank you.")
//End if 
//
//Else   ` passwords did not match
//ALERT("Sorry, your passwords did not match, password remains the same !")
//End if 
//End if 

C_TEXT:C284($newPassword; $currentUser)
$currentUser:=Current user:C182
$newPassword:=requestChangePassword("admin")
If (Current user:C182#vUserName)
	myAlert("Please log into this account before changing the password")
Else 
	If ($newPassword#"")  // actually change the user's password
		//CHANGE PASSWORD($newPassword)
		changePassword($newPassword)
		myAlert("Password changed successfuly!")
	End if 
End if 

<>SystemUser:=Current user:C182
<>ApplicationUser:=Current user:C182
<>UserID:=String:C10(getSystemUserID(Current user:C182))

