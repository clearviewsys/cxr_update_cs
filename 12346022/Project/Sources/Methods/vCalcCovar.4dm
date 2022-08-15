//%attributes = {"publishedWeb":true}
// vCalcCovar (-> v1;->v2)
// PRE:  |v1| = |v2|
// ∑ xi.yi/n -(µx.µy)

C_POINTER:C301($1; $2)
C_POINTER:C301($vPtr1; $vPtr2)
C_REAL:C285($0; $product; $productSum; $sum1; $sum2; $mean1; $mean2; $vi1; $vi2; $sumSqr; $sum; $stdv1; $stdv2; $covar)
C_LONGINT:C283($i; $n)

$vPtr1:=$1
$vPtr2:=$2

$n:=Size of array:C274($vPtr1->)

If ($n>0)
	$sumSqr:=0
	$sum:=0
	$stdv1:=0
	$stdv2:=0
	$covar:=0
	$n:=Size of array:C274($vPtr1->)
	For ($i; 1; $n)
		$vi1:=$vPtr1->{$i}
		$vi2:=$vPtr2->{$i}
		$product:=$vi1*$vi2
		$productSum:=$productSum+$product
		$sum1:=$sum1+$vi1
		$sum2:=$sum2+$vi2
	End for 
	$mean1:=$sum1/$n
	$mean2:=$sum2/$n
	
	$covar:=($productSum/$n)-($mean1*$mean2)  // ∑ xi.yi/n -(µx.µy)
	$0:=$covar
	
Else 
	$0:=0
End if 