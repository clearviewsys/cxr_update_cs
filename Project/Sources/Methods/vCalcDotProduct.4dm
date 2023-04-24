//%attributes = {"publishedWeb":true}
// vCalcDotProduct (-> v1;->v2) ->real
// PRE:  |v1| = |v2|
// ∑ xi.yi/n -(µx.µy)

C_POINTER:C301($1; $2)
C_POINTER:C301($vPtr1; $vPtr2)
C_REAL:C285($0; $product; $sum; $productSum; $vi1; $vi2)
C_LONGINT:C283($i; $n)

$vPtr1:=$1
$vPtr2:=$2

$n:=Size of array:C274($vPtr1->)

If ($n>0)
	$sum:=0
	$productSum:=0
	$n:=Size of array:C274($vPtr1->)
	For ($i; 1; $n)
		$vi1:=$vPtr1->{$i}
		$vi2:=$vPtr2->{$i}
		$product:=$vi1*$vi2
		$productSum:=$productSum+$product
	End for 
	$0:=$productSum
Else 
	$0:=0
End if 