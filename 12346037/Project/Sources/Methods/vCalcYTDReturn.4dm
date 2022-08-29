//%attributes = {}
// vCalcYTDreturn(->DatesBOM;->BOMNAVs;->EOMNAVs) -> YTD Return
C_POINTER:C301($1; $2; $3)
C_REAL:C285($0)
C_DATE:C307($fromDate; $toDate)

$toDate:=$1->{Size of array:C274($1->)}
$fromDate:=calcBOYear($toDate)  // do not change the order of $fromDate;$toDate

$0:=vCalcReturnForPeriod($1; $2; $3; $fromDate; $toDate)
