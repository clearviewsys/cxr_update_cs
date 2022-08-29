//%attributes = {"shared":true}
C_POINTER:C301($1)  // Jan 17, 2012 12:11:03 -- I.Barclay Berry 

If (isUserAdministrator)
	displayLBox_(->[FeeStructures:38])
Else 
	myAlert_AdminPrivilegeNeeded
End if 