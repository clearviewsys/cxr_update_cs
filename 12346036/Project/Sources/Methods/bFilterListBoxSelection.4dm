//%attributes = {}
C_POINTER:C301($tablePtr; $1)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Not:C34(Is nil pointer:C315($tablePtr)))
	C_TEXT:C284($listboxSetName)
	$listboxSetName:=makeSetNameForTable($tablePtr)
	If (Records in set:C195($listboxSetName)=0)
		// do nothing
	Else 
		USE SET:C118($listboxSetName)
		CREATE SET:C116($tablePtr->; $listboxSetName)
		//REDRAW LISt(mainListBox)
		
		//HIGHLIGHT RECORDS(current form table->;$listboxSetName)
		//redraw(mainListBox)
		//LISTBOX SELECT ROW(*;"mainListBox")
		
	End if 
End if 