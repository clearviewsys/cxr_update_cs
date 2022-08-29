//%attributes = {}
// initWebVariables (»Table)
// create a varialbe for every Alpha field associated to the Table
// and initialize them to ""

C_POINTER:C301($1)
C_POINTER:C301($theVarPtr)
C_LONGINT:C283($i; $fieldType; $tableNum)

$tableNum:=Table:C252($1)

For ($i; 1; Get last field number:C255($1))
	If (Is field number valid:C1000($tableNum; $i))  // Jan 16, 2012 18:28:05 -- I.Barclay Berry 
		$theVarPtr:=Get pointer:C304("web"+Field name:C257($tableNum; $i))
		$theVarPtr->:=""
	End if 
End for 
