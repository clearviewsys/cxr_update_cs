//%attributes = {}
// keepBooleanFieldStatic (->booleanField;oldBooleanValueToKeep)
// this method will keep the value of the boolean field the same as the old value if the old value is equal to a certain value
// e.g. keepBooleanStateStatic (->[ewires]isSettled; true)
// this will prevent to unsettle a paid eWire. 

C_POINTER:C301($fieldPtr; $1)
C_BOOLEAN:C305($booleanState; $2)

$fieldPtr:=$1
$booleanState:=$2

If ((Old:C35($fieldPtr->)=$booleanState) & ($fieldPtr->=Not:C34($booleanState)))  // if the new state of the field is no longer the same as the oldvalue
	
	$fieldPtr->:=$booleanState  // keep the old value static 
End if 