//%attributes = {"shared":true}

If (isUserAdministrator)
	displayLBox_(->[TransactionTypes:93])
Else 
	myAlert_AdminPrivilegeNeeded
End if 

