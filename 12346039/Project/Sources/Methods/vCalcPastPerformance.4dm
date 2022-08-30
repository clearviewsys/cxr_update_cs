//%attributes = {"publishedWeb":true}
//vCalcPastPerformance(->EOMvaluesArray;n_months) - > real
// retuns the past n months performance
// the values array is like NAV Array
// if the month doesn't exist it returns 0

C_POINTER:C301($1)
C_LONGINT:C283($2)

C_LONGINT:C283($n; $months)
$n:=Size of array:C274($1->)
$months:=$2
If ($n>=$months)
	$0:=calcPctChange($1->{$n-$months}; $1->{$n})
Else 
	$0:=0
End if 
