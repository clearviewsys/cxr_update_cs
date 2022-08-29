//%attributes = {}
// normalizeFullName (->string) 
C_POINTER:C301($1; $fieldPtr)
$fieldPtr:=$1

$fieldPtr->:=removeEnclosingSpaces(toTitleCase($fieldPtr))
