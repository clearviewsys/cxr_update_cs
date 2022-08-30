//%attributes = {}
// isRateOffRange (base; sample;{toleranceRate}) ->boolean
// this methods checks the sample against the base and see if it is off limit


C_REAL:C285($1; $2; $3)
C_REAL:C285(<>errorTolerance)
C_REAL:C285($upperRange; $lowerRange; $tolerance)

Case of 
	: (Count parameters:C259=2)
		$tolerance:=<>errorTolerance
	: (Count parameters:C259=3)
		$tolerance:=$3
End case 

$upperRange:=$1*(1+$tolerance)
$lowerRange:=calcSafeDivide($1; (1+$tolerance))  // the calculation of the lower range is different
// the reason is: say if the tolerance is %100, the upper range is twice the amount of the base (say 1)
// but the lowerrange would become 0 which is (1-1) not an acceptable rate. Therefore
// we say what is the number x where after applying the acceptable tolerance r% would be the base b
// x(1+r%)= base. After applying the r% to it we reach the base
// so in the case of the above example the answer would be 0.5. If we add 100% of 0.5 to itself we 
// will reach the base which was 1. 


If (($2<=$lowerRange) | ($2>=$upperRange))
	$0:=True:C214
Else 
	$0:=False:C215
End if 

