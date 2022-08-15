//%attributes = {}
// vecInitialize (->arr; ->initValue)
// this method sets all the data of the array to initValue
// PRE; array must be valid

C_POINTER:C301($1; $2; $arrPtr; $valuePtr)
C_LONGINT:C283($i)

$arrPtr:=$1
$valuePtr:=$2

For ($i; 1; Size of array:C274($arrPtr->))
	$arrPtr->{$i}:=$valuePtr->  // set the array(i) to initValue
End for 
