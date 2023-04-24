//%attributes = {"publishedWeb":true}
// vDotProduct (-> vec1 ; -> vec2 -> resultVector)
// PRE: size of (v1)= size of (v2)
// * must be defined for elements of the vectors (intented for real arrays)

C_LONGINT:C283($i)
C_POINTER:C301($1; $2; $3)

For ($i; 1; Size of array:C274($1->))
	$3->{$i}:=($1->{$i})*($2->{$i})
End for 