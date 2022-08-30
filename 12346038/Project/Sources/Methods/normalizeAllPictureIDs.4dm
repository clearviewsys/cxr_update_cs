//%attributes = {}
C_BOOLEAN:C305(<>enableTriggers)

If (isUserAdministrator)
	<>enableTriggers:=False:C215
	updateTableUsingMethod(->[Customers:3]; "NormalizePictureID"; True:C214)
	<>enableTriggers:=True:C214
Else 
	
	myAlert_AdminPrivilegeNeeded
End if 