//%attributes = {}
// setEnterableIff (booleanCondition; objectName)
// Set enterable if and only if the condition is true

C_BOOLEAN:C305($1)
C_TEXT:C284($2)

If ($1)
	OBJECT SET ENTERABLE:C238(*; $2; True:C214)
Else 
	OBJECT SET ENTERABLE:C238(*; $2; False:C215)
End if 