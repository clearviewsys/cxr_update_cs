//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $tablePtr)
C_TEXT:C284(vRecNum)

If (Count parameters:C259=1)
	$tablePtr:=$1
Else 
	$tablePtr:=Current form table:C627
End if 

If (Selected record number:C246($tablePtr->)<0)
	vRecNum:=""
Else 
	vRecNum:=String:C10(Selected record number:C246($tablePtr->))+" of "+String:C10(Records in selection:C76($tablePtr->))
End if 

handleNavigationButtonsState($tablePtr)