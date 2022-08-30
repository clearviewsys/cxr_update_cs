//%attributes = {"publishedWeb":true}
// vCalcStdev (-> vector)
// PRE: vector must have at least one item

C_POINTER:C301($1)
C_POINTER:C301($vPtr)
C_REAL:C285($0; $sum; $mean; $stdv; $sumSqr; $vi)
C_LONGINT:C283($i; $n)

$vPtr:=$1
$n:=Size of array:C274($vPtr->)

If ($n>1)
	$sumSqr:=0
	$sum:=0
	$stdv:=0
	$n:=Size of array:C274($vPtr->)
	
	For ($i; 1; $n)
		$vi:=$vPtr->{$i}
		$sum:=$sum+$vi
		$sumSqr:=$sumSqr+($vi^2)
	End for 
	
	$mean:=$sum/$n
	$stdv:=Square root:C539(($sumSqr/$n)-($mean^2))
	
	$0:=$stdv
	
Else 
	$0:=0
	
End if 