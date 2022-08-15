//%attributes = {"publishedWeb":true}
// vGetTendencyVars (-> vector;->sum;->min;->max;->mean;->std)
// PRE: vector must have at least one item

C_POINTER:C301($1; $2; $3; $4; $5; $6)
C_POINTER:C301($vPtr)
C_REAL:C285($0; $sum; $min; $max; $mean; $stdv; $sumSqr; $vi)
C_LONGINT:C283($i; $n)

$vPtr:=$1
$n:=Size of array:C274($vPtr->)

If ($n>0)
	$sumSqr:=0
	$sum:=0
	$min:=$vPtr->{1}
	$max:=$vPtr->{1}
	$stdv:=0
	$n:=Size of array:C274($vPtr->)
	For ($i; 1; $n)
		$vi:=$vPtr->{$i}
		$sum:=$sum+$vi
		$sumSqr:=$sumSqr+($vi^2)
		If ($vi<$min)
			$min:=$vi
		End if 
		If ($vi>$max)
			$max:=$vi
		End if 
	End for 
	$mean:=$sum/$n
	$stdv:=Square root:C539(($sumSqr/$n)-($mean^2))
	
	$2->:=$sum
	$3->:=$min
	$4->:=$max
	$5->:=$mean
	$6->:=$stdv
Else 
	$2->:=0
	$3->:=0
	$4->:=0
	$5->:=0
	$6->:=0
End if 