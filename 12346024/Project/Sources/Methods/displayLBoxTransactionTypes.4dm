//%attributes = {"shared":true}
If (isUserAdministrator)
	displayLBox(->[TransactionTypes:93])
Else 
	myAlert_AdminPrivilegeNeeded
End if 