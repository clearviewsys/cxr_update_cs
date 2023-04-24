If (Form event code:C388=On Clicked:K2:4)
	C_POINTER:C301($tablePtr)
	C_LONGINT:C283($tableNum; $index)
	//$tablePtr:=Table(arrTableNames)
	$index:=Self:C308->
	$tableNum:=(arrTableNums{$index})  // get the table
	$tablePtr:=Table:C252($tableNum)
	GET FIELD TITLES:C804($tablePtr->; arrFieldNames; arrFieldNums)
	
	
End if 