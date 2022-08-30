//%attributes = {}
// hideObjectsOnTrue( booleanExpression ; objectName)


C_BOOLEAN:C305($1)
C_TEXT:C284($2)
If ($1)
	OBJECT SET VISIBLE:C603(*; $2; False:C215)
Else 
	OBJECT SET VISIBLE:C603(*; $2; True:C214)
End if 
