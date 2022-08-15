//%attributes = {}
// vFillAbbrDates(->v1;startDate;daysStep;monthStep;yearStep)

// PRE: |v1|>0

C_POINTER:C301($1)
C_DATE:C307($2; $nextDate)
C_LONGINT:C283($3; $4; $5; $i)

$1->{1}:=getAbbrDateString($2)
$nextDate:=$2
For ($i; 2; Size of array:C274($1->))
	$nextDate:=Add to date:C393($nextDate; $5; $4; $3)
	$1->{$i}:=getAbbrDateString($nextDate)
End for 