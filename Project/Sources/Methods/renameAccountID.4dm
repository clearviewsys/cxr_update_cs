//%attributes = {"shared":true}
C_TEXT:C284($accountID; $1)
If (isUserAdministrator)
	Case of 
		: (Count parameters:C259=0)
			$accountID:=""
			
		: (Count parameters:C259=1)
			$accountID:=$1
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 
	
	
	If (isUserAdministrator)
		// Replaced on: 2/3/2017 BY: CVS Dev. Team
		myAlert("It is recommended to rename an account when all users are offline!")
		//myAlert (GetLocalizedErrorMessage (3886))
		If ($accountID="")
			renameAccountIDsGlobally
		Else 
			renameAccountIDsGlobally($accountID)
		End if 
	Else 
		myAlert(GetLocalizedErrorMessage(4130))
	End if 
	
Else 
	myAlert_AdminPrivilegeNeeded
End if 