//%attributes = {}
// vCalcYTDreturn(->DatesBOM;->BOMNAVs;->EOMNAVs) -> Since Inception Return

C_POINTER:C301($1; $2; $3)
C_REAL:C285($0)
C_DATE:C307($fromDate; $toDate)
If (Size of array:C274($1->)>0)
	$toDate:=$1->{Size of array:C274($1->)}
	$fromDate:=$1->{1}  // do not change the order of $fromDate;$toDate

	
	$0:=vCalcReturnForPeriod($1; $2; $3; $fromDate; $toDate)
Else 
	$0:=0
End if 