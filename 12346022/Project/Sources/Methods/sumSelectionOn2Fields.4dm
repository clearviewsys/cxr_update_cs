//%attributes = {}
// sumSelectionOn2Fields(->table;->field1;->field2;->result1;->result2)

// use this method inside print report (form methods) because apparently sum won't properly work


C_POINTER:C301($1; $2; $3; $4; $5)
C_LONGINT:C283($i)
C_REAL:C285($sum1; $sum2)

$sum1:=0
$sum2:=0
FIRST RECORD:C50($1->)
For ($i; 1; Records in selection:C76($1->))
	$sum1:=$sum1+$2->
	$sum2:=$sum2+$3->
	NEXT RECORD:C51($1->)
End for 

$4->:=$sum1
$5->:=$sum2