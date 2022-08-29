//%attributes = {}
// appendToArray(->array; ->element)

C_POINTER:C301($1; $2)
C_LONGINT:C283($vlElem)

$vlElem:=Size of array:C274($1->)+1
INSERT IN ARRAY:C227($1->; $vlElem)
$1->{$vlElem}:=$2->
