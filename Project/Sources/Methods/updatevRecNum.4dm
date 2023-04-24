//%attributes = {}
C_TEXT:C284(vRecNum)
C_POINTER:C301($tablePtr; $1)
C_LONGINT:C283($n)

Case of 
	: (Count parameters:C259=0)  // don't change this case (0) for backward compatibility
		$tablePtr:=Current form table:C627
	: (Count parameters:C259=1)
		$tablePtr:=($1)
End case 

$n:=Records in selection:C76($tablePtr->)
vRecNum:=String:C10($n)+" records in selection."
