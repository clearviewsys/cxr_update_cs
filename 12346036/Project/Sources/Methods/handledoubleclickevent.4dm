//%attributes = {}
// handleDoubleClickEvent ({tablePtr})
// e.g. handleDoubleClickEvent (current form table)


C_POINTER:C301($formTablePtr)

Case of 
	: (Count parameters:C259=1)
		$formTablePtr:=$1
	Else 
		$formTablePtr:=Current form table:C627
End case 


COPY NAMED SELECTION:C331($formTablePtr->; getTableNamedSelection($formTablePtr))

C_LONGINT:C283($selectedRecord)
$selectedRecord:=Selected record number:C246($formTablePtr->)
If ($selectedRecord>=0)
	displayRecord($formTablePtr; $selectedRecord)
	FILTER EVENT:C321
End if 

