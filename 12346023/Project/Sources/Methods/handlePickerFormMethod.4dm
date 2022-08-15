//%attributes = {}
If (Form event code:C388=On Load:K2:1)
	SET TIMER:C645(-1)
End if 

If (Form event code:C388=On Timer:K2:25)
	C_OBJECT:C1216($eSel)
	SET TIMER:C645(0)
	
	If (Get edited text:C655#"")
		C_TEXT:C284($searchCommand)
		$searchCommand:=Form:C1466.searchMethod
		EXECUTE METHOD:C1007($searchCommand; *; Get edited text:C655)
		C_POINTER:C301($tablePtr)
		$tablePtr:=Current form table:C627
		$eSel:=Create entity selection:C1512($tablePtr->)  // map the selection of the table to the entity selection
		Form:C1466.pickerList:=$eSel
		Form:C1466.pickerList:=Form:C1466.initialList.and($eSel)  // get the intersection of the search with the original selection
		If (Form:C1466.pickerList.length>0)
			Form:C1466.pickerList.first()
			LISTBOX SELECT ROW:C912(*; "ListBox"; 1)
		End if 
	Else 
		Form:C1466.pickerList:=Form:C1466.initialList
	End if 
End if 