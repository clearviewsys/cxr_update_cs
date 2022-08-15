//%attributes = {"publishedWeb":true}
// vFillWithConstant (-> vec1 ; real c)
// v(i) = c  

C_LONGINT:C283($i)
C_REAL:C285($2)
C_POINTER:C301($1)

For ($i; 1; Size of array:C274($1->))
	$1->{$i}:=$2
End for 