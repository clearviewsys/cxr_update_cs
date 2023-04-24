//%attributes = {}
If (isUserAdministrator)
	displayLBox_(->[PaymentTypes:116])
Else 
	myAlert_AdminPrivilegeNeeded
End if 

