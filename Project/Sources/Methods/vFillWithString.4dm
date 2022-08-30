//%attributes = {}
// vFillWithString (-> vec1 ; string)
// v(i) = c  

C_LONGINT:C283($i)
C_TEXT:C284($2)
C_POINTER:C301($1)

For ($i; 1; Size of array:C274($1->))
	$1->{$i}:=$2
End for 