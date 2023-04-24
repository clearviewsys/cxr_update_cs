//%attributes = {"publishedWeb":true}
// vGetRiskVars(
//->vValuesArray; 1
// -> vPctChangeArray;2
//->vCompoundedReturn; 3
//->vAnnualizedStdv; 4
//->vSharpe 5
//-> ReturnRisk 6
//-> Sterling 7

C_POINTER:C301($1; $2; $3; $4; $5; $6; $7)
C_REAL:C285($annStdvChange)
C_REAL:C285($sum; $min; $max; $mean; $stdev)
C_REAL:C285(<>RiskFreeRate)
<>riskFreeRate:=0.04

C_POINTER:C301($vPtr)
C_LONGINT:C283($n)
$vPtr:=$1
$n:=Size of array:C274($vPtr->)
If ($n>2)
	vGetTendencyVars($2; ->$sum; $7; ->$max; ->$mean; $4)
	// remember that pointers to local vars do not work
	// in order to recycle variables I have used $4 and $7 
	
	$3->:=calcAnnualizedReturn($vPtr->{1}; $vPtr->{$n}; $n)  // compounded return
	$4->:=Square root:C539(12)*($4->)  // annualized stdev
	$5->:=calcSharpeRatio($3->; <>RiskFreeRate; $4->)  // sharpe ratio
	$6->:=calcReturnRisk($3->; $4->)  // return/risk ratio
	$7->:=calcSterling($3->; $7->)  // sterling
Else 
	$3->:=0
	$4->:=0
	$5->:=0
	$6->:=0
	$7->:=0
	
End if 