C_POINTER:C301($tablePtr)
C_TEXT:C284(vRecNum)

$tablePtr:=Current form table:C627

If (Selected record number:C246($tablePtr->)<0)
	Self:C308->:=""
Else 
	Self:C308->:=String:C10(Selected record number:C246($tablePtr->))+" of "+String:C10(Records in selection:C76($tablePtr->))
End if 

handleNavigationButtonsState($tablePtr)