//%attributes = {}
// sumSelection(->[table];->realField1) -> sum

C_POINTER:C301($1; $2; $3)
C_REAL:C285($sum; $0)

$sum:=0

C_LONGINT:C283($i)
READ ONLY:C145($1->)
FIRST RECORD:C50($1->)
While (Not:C34(End selection:C36($1->)))
	$sum:=$sum+$2->
	NEXT RECORD:C51($1->)
End while 

$0:=$sum
