//%attributes = {}
// listBox_ editLastRow (->array)
// NOTE: DO NOT SEND THE LIST BOX Pointer , instead send the first array 


C_POINTER:C301($arrPointer)
$arrPointer:=$1

EDIT ITEM:C870($arrPointer->; Size of array:C274($arrPointer->))
