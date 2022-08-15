//%attributes = {}
// updateTextField (->fieldPtr;->valuePtr)


C_POINTER:C301($1; $2; $fieldPtr; $valuePtr)

$fieldPtr:=$1
$valuePtr:=$2

If ($valuePtr->="")
	$fieldPtr->:=$valuePtr->
End if 

