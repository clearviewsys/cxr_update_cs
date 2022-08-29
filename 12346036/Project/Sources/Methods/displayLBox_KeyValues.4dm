//%attributes = {}


If (isUserAdministrator) | (isUserDesigner)
	displayLBox_(->[KeyValues:115])
Else 
	myAlert_AdminPrivilegeNeeded
End if 

