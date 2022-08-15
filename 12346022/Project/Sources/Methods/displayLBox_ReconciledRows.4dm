//%attributes = {"shared":true}
If (isUserAdministrator)
	displayLBox_(->[ReconciledRows:85])
Else 
	myAlert_AdminPrivilegeNeeded
End if 

