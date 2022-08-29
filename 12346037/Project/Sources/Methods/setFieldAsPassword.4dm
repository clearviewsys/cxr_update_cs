//%attributes = {}
// setFieldAsPassword (objectPtr)
// c_pointer($1)

C_POINTER:C301($1; $fieldPtr)
$fieldPtr:=$1

OBJECT SET FONT:C164($fieldPtr->; "%Password")
