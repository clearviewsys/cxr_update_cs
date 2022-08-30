//%attributes = {"publishedWeb":true}
// vScalarMultiply (real c; -> v1 ; ->resultVector)
// scalar multiplicatio must be defined for the vectors 
// this is (intented for real arrays)
// c.v1 --> v2

C_LONGINT:C283($i)
C_REAL:C285($1)
C_POINTER:C301($2; $3)

For ($i; 1; Size of array:C274($2->))
	$3->{$i}:=$1*$2->{$i}
End for 