//%attributes = {}
//dont think this is used --ibb
//iLB_StartUp 
//iLB_Init_NewProcess 
If (isUserAdministrator)
	displayLBox_(->[Audit:118])
Else 
	myAlert_AdminPrivilegeNeeded
End if 

