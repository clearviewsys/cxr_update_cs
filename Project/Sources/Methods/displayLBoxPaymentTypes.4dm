//%attributes = {}
If (isUserAdministrator)
	displayLBox(->[PaymentTypes:116])
Else 
	myAlert_AdminPrivilegeNeeded
End if 