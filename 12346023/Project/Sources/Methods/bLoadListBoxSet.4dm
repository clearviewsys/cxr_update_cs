//%attributes = {}
// bLoadListBoxSet ({->[table]})
// see also: bSaveListBoxSet


C_POINTER:C301($1; $tablePtr)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Not:C34(Is nil pointer:C315($tablePtr)))
	
	C_TEXT:C284($tableSetName; $filePath)
	$tableSetName:=makeSavedSetNameForTable($tablePtr)
	
	If (Shift down:C543)
		$filePath:=""
	Else 
		$filePath:=$tableSetName
	End if 
	
	LOAD SET:C185($tablePtr->; $tableSetName; $filePath)
	If (Records in set:C195($tableSetName)>0)
		USE SET:C118($tableSetName)
	End if 
	
	CLEAR SET:C117($tableSetName)
End if 