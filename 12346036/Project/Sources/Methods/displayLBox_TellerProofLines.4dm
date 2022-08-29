//%attributes = {"shared":true}
If (isUserAdministrator)
	displayLBox_(->[TellerProofLines:79])
	
Else 
	myAlert_AdminPrivilegeNeeded
End if 

