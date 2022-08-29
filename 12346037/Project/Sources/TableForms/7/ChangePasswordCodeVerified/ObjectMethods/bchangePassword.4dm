checkInit
C_TEXT:C284($error)

checkAddErrorIf(Not:C34(isPasswordStrong(vNewPassword1; ->$error)); "Password is not strong!")
checkAddErrorIf(checkUsedPassword(vNewPassword1); "This password has been used before on the system,"+Char:C90(Carriage return:K15:38)+"please choose a different one")
If ([Users:25]isHashed:36)
	checkAddErrorIf(Verify password hash:C1534(vNewPassword1; vCurrentPassword); "Your new and old password cannot be the same!")
Else 
	checkAddErrorIf((vCurrentPassword=vNewPassword1); "Your new and old password cannot be the same!")
	
End if 

If (isValidationConfirmed(True:C214))
	vPassword:=vNewPassword1
Else 
	REJECT:C38
End if 