//%attributes = {}
// setBooleanIf (condition; ->boolean)
// this method sets the boolean variable if the condition is right

C_BOOLEAN:C305($condition; $1)
C_POINTER:C301($booleanVarPtr; $2)

$condition:=$1
$booleanVarPtr:=$2
ASSERT:C1129($booleanVarPtr#Null:C1517)

If ($condition)
	$booleanVarPtr->:=True:C214
End if 