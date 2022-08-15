//%attributes = {"publishedWeb":true}
// vFillDates(->v1;startDate;daysStep;monthStep;yearStep)
// PRE: |v1|>0
C_POINTER:C301($1)
C_DATE:C307($2)
C_LONGINT:C283($3; $4; $5; $i)

$1->{1}:=$2
For ($i; 2; Size of array:C274($1->))
	$1->{$i}:=Add to date:C393($1->{$i-1}; $5; $4; $3)
End for 