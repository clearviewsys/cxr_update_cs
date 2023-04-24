//%attributes = {"publishedWeb":true}
// vCalcMean (-> vector) -> real
// vector mean

C_POINTER:C301($1)
C_REAL:C285($0; $sum)
C_LONGINT:C283($i)

$sum:=0

For ($i; 1; Size of array:C274($1->))
	$sum:=$sum+$1->{$i}
End for 

$0:=$sum/Size of array:C274($1->)