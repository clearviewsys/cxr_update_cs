//%attributes = {}
//enableButtonIf (booleanCondition;string: buttonObject)

C_BOOLEAN:C305($1)
C_TEXT:C284($2)

If ($1)
	OBJECT SET ENABLED:C1123(*; $2; True:C214)
	
Else 
	OBJECT SET ENABLED:C1123(*; $2; False:C215)
	
End if 
