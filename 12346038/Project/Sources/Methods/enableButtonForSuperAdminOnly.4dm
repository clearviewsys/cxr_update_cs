//%attributes = {}
// enableButtonForAdminOnly(objectName)
C_TEXT:C284($1)

If (isUserSuperAdmin)
	//_O_ENABLE BUTTON(*;$1)
	OBJECT SET ENABLED:C1123(*; $1; True:C214)
	
Else 
	//_O_DISABLE BUTTON(*;$1)
	OBJECT SET ENABLED:C1123(*; $1; False:C215)
	
End if 