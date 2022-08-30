//%attributes = {}
// listBox_ editFirstRow (->array)
// NOTE: DO NOT SEND THE LIST BOX Pointer , instead send the first array 


C_POINTER:C301($arrPointer)
$arrPointer:=$1
If (Size of array:C274($arrPointer->)>0)
	EDIT ITEM:C870($arrPointer->; 1)
Else 
	BEEP:C151
End if 
