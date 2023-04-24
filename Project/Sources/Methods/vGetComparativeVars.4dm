//%attributes = {"publishedWeb":true}
// vGetCompVars(
// -> vPCTChanges : monthly pct change array for fund . 1
// -> vBMPCTChange: montly pct change array for BM . 2
// -> Beta (returned) .3 
// -> Alpha (returned) .4
// -> RSqr (returned) .5
// -> Treynor (returned) .6
// -> Appraisal (returned).7 )
// This method calculates the alpha, Beta, etc and return the variables
// warning: all calculations are MONTHLY 

C_POINTER:C301($1; $2; $3; $4; $5; $6; $7)
C_REAL:C285($vMeanChange; $vBM_MeanChange; $vVarChange; $vBM_VarChange; $vStdvChange)
C_REAL:C285($vBeta; $vAlpha; $vRsqr; $vTreynor; $vAppraisal)

If ((Size of array:C274($1->)=Size of array:C274($2->)) & (Size of array:C274($1->)>2))
	$vMeanChange:=vCalcMean($1)  // calculate monthly change average for fund
	$vBM_MeanChange:=vCalcMean($2)  // calculate montly change average for BM
	$vVarChange:=vCalcVar($1)
	$vBM_VarChange:=vCalcVar($2)
	$vStdvChange:=vCalcStdev($1)
	
	$vBeta:=vCalcBeta($1; $2)
	$vAlpha:=calcAlpha($vMeanChange; $vBM_MeanChange; (<>RiskFreeRate/12); $vBeta)
	$vRsqr:=CalcRSqr($vBeta; $vVarChange; $vBM_VarChange)
	$vTreynor:=calcTreynor($vAlpha; $vBeta)
	$vAppraisal:=calcAppraisal($vAlpha; $vStdvChange)
	
	$3->:=$vBeta
	$4->:=$vAlpha
	$5->:=$vRSqr
	$6->:=$vTreynor
	$7->:=$vAppraisal
Else 
	$3->:=0
	$4->:=0
	$5->:=0
	$6->:=0
	$7->:=0
End if 