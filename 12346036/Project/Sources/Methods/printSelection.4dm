//%attributes = {}
// printSelection(->[table];formName)
// emulates printSelection using print form command
// use this as a template to print using different forms based on condition

C_POINTER:C301($tablePtr; $1)
C_TEXT:C284($formName; $2)
C_LONGINT:C283($vlRecord)

$tablePtr:=$1
$formName:=$2

If (OK=1)
	orderByTable($tablePtr)
	If (OK=1)
		PRINT SETTINGS:C106  // Display Printing dialog boxes
		If (OK=1)
			For ($vlRecord; 1; Records in selection:C76($tablePtr->))
				Print form:C5($tablePtr->; $formName)  // Use one form for checks
				NEXT RECORD:C51($tablePtr->)
			End for 
			PAGE BREAK:C6  // Make sure the last page is printed
		End if 
	End if 
End if 