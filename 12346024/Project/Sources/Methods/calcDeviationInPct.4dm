//%attributes = {}
// calcDeviation (base,sample): deviance in percentage
// this method will return how much the sample is off from the base
// no need to multiple by 100

C_REAL:C285($base; $sample; $deviance; $1; $2; $0)

$base:=$1
$sample:=$2

If ($sample>$base)
	$deviance:=calcSafeDivide(($sample-$base); $base)*100
Else 
	$deviance:=calcSafeDivide(($base-$sample); $sample)*100
End if 

$0:=$deviance