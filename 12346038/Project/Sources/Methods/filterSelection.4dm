//%attributes = {}
C_TEXT:C284($listboxSetName)
$listboxSetName:=makeSetNameForTable(Current form table:C627)
If (Records in set:C195($listboxSetName)=0)
	// do nothing
Else 
	USE SET:C118($listboxSetName)
	CREATE SET:C116(Current form table:C627->; $listboxSetName)
	
	//HIGHLIGHT RECORDS(current form table->;$listboxSetName)
	//redraw(mainListBox)
	//LISTBOX SELECT ROW(*;"mainListBox")
	
End if 