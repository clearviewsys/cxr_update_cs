//%attributes = {}
// vecIsHomogeneous (-> vector) -> boolean
// check if all the values in an array the same (textual array only)
// WARNING: ONLY TEXT ARRAYs

C_POINTER:C301($1)
C_BOOLEAN:C305($0; $result)
ARRAY TEXT:C222($arrTemp; 0)
C_LONGINT:C283($i; $n)
$n:=Size of array:C274($1->)
$result:=True:C214
COPY ARRAY:C226($1->; $arrTemp)
SORT ARRAY:C229($arrTemp)

For ($i; 1; $n-1)
	If ($arrTemp{$i}#$arrTemp{$i+1})  // if two consecutive elements don't match quit the loop and result false
		$result:=False:C215
		$i:=$n  // quit the loop
	End if 
End for 

ARRAY TEXT:C222($arrTemp; 0)  // clear the temporary array from memory
$0:=$result
