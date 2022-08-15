//%attributes = {"publishedWeb":true}
// vFillWithConstant (-> vec1 ; real startvalue;real rate)
// v(i) = c+r.i 

C_POINTER:C301($1)
C_REAL:C285($2; $3)
C_LONGINT:C283($i)

For ($i; 1; Size of array:C274($1->))
	$1->{$i}:=$2+(($i-1)*$3)
End for 