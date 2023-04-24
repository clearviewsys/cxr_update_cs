C_POINTER:C301($formTablePtr)
C_LONGINT:C283($selectedRecord)

$formTablePtr:=->[ImportedRows:91]

If (Form event code:C388=On Double Clicked:K2:5)
	
	$selectedRecord:=Selected record number:C246($formTablePtr->)
	If ($selectedRecord>=0)
		//displayRecord ($formTablePtr;$selectedRecord)
		matchImportedRowToRegister
		FILTER EVENT:C321
	End if 
	
End if 