//%attributes = {"shared":true}
If (isUserAdministrator | isUserController | isUserComplianceOfficer | isUserManager)
	displayLBox_(->[RegistersAuditTrail:88])
Else 
	myAlert("This module is restricted to Controllers, Managers, and Compliance Officers")
End if 

