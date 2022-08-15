//%attributes = {}
C_TEXT:C284($1; $methodName)
$methodName:=$1

myAlert($methodName)

CONFIRM:C162("Are you sure you want to execute "+$methodName+"?")
If (OK=1)
	EXECUTE METHOD:C1007($methodName)
End if 

