//%attributes = {}
// validateUsers
// [Users];"Entry"

checkUniqueKey(->[Users:25]; ->[Users:25]UserID:1; "UserID")
checkUniqueKey(->[Users:25]; ->[Users:25]UserName:3; "Username")

checkIfNullString(->[Users:25]UserName:3; "User Name")

If (Not:C34([Users:25]isInactive:18))
	checkAddWarningOnTrue(([Users:25]Reminder:5=""); "It is recommended to provide a reminder for your password.")
	checkAddWarningOnTrue(([Users:25]BranchID:17=""); "It is recommended to assign users to a branch. ")
	
	checkAddErrorIf(([Users:25]UserName:3="guest"); "The user name guest is reserved by the system.")
	C_BOOLEAN:C305($passwordUsed)
	If (Old:C35([Users:25]Password:4)#[Users:25]Password:4)
		$passwordUsed:=checkUsedPassword([Users:25]Password:4)
		checkAddErrorIf($passwordUsed; "This password has been used before on the system,"+Char:C90(Carriage return:K15:38)+"please choose a different one")
		If (Not:C34($passwordUsed))
			addUsedPassword([Users:25]Password:4)
		End if 
	End if 
	
	//checkAddErrorIf (([Users]UserName="Admin");"Admin is reserved by the system. Please use a different name.")
	C_TEXT:C284($error)
	
	If (Not:C34(isPasswordStrong([Users:25]Password:4; ->$error)))
		checkAddWarningIf($error#""; $error)
	End if 
End if 
