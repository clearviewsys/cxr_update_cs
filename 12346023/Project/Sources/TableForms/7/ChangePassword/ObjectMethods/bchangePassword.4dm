checkInit
C_TEXT:C284($error)


Case of 
	: (vUserName="Designer")  // designer must be checked first in the case (because isUserAministrator returns true if user is designer, so the case)
		checkAddErrorIf(Not:C34(Validate password:C638(vUserName; vOldPassword)); "Current Designer password is not correct")
		
	: (vUserName="Administrator")  // administrators
		checkAddErrorIf(Not:C34(Validate password:C638(vUserName; vOldPassword)); "Current Administrator password is not correct")
		
	: (vUserName="Support")  // administrators
		checkAddErrorIf(Not:C34(Validate password:C638(vUserName; vOldPassword)); "Current 'Support Team' password is not correct")
		
	Else   // normal users
		If ([Users:25]isHashed:36)
			checkAddErrorIf(Not:C34(Verify password hash:C1534(vOldPassword; [Users:25]Password:4) | (vOldPassword=[Users:25]Password:4)); "Old password is not correct")
		Else 
			checkAddErrorIf((vOldPassword#vCurrentPassword); "Old password is not correct")
		End if 
End case 

checkAddErrorIf(Not:C34(isPasswordStrong(vNewPassword1; ->$error)); "Password is not strong!")
checkAddErrorIf((vOldPassword=vNewPassword1); "Your new and old password cannot be the same!")
checkAddErrorIf(checkUsedPassword(vNewPassword1); "This password has been used before on the system,"+Char:C90(Carriage return:K15:38)+"please choose a different one")

If (isValidationConfirmed(True:C214))
	vPassword:=vNewPassword1
Else 
	REJECT:C38
End if 