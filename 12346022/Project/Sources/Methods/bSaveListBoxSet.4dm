//%attributes = {}
// bSaveListBoxSet (->tablePtr)
// see also: bLoadListBoxSet

// getBuild

C_POINTER:C301($1; $tablePtr)
C_TEXT:C284($tableSetName)
C_TEXT:C284($listboxSetName)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Not:C34(Is nil pointer:C315($tablePtr)))
	
	$listboxSetName:=makeSetNameForTable($tablePtr)
	
	If (Shift down:C543)
		$tableSetName:=""  // to save anywhere by any name
	Else 
		$tableSetName:=makeSavedSetNameForTable($tablePtr)
	End if 
	
	If (Records in set:C195($listboxSetName)>0)
		//COPY SET($listboxSetName;$tableSetName)
		SAVE SET:C184($listboxSetName; $tableSetName)
	Else 
		BEEP:C151
	End if 
	
	CLEAR SET:C117($tableSetName)
End if 