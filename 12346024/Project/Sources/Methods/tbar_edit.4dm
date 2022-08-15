//%attributes = {}
// tbar_edit ({->[table]})


C_POINTER:C301($tablePtr; $1)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($myFormula)
$myFormula:=""

If (Form event code:C388=On Clicked:K2:4)
	If (Shift down:C543)
		
		If (isUserSuperAdmin)
			
			myConfirm("This feature is for programmers and powerusers only. Make sure you know what you're doing before proceeding."; "Continue"; "Cancel")
			
			If (OK=1)
				EDIT FORMULA:C806($tablePtr->; $myFormula)
				If (OK=1)
					READ WRITE:C146($tablePtr->)
					
					//APPLY TO SELECTION(Current form table->;(EXECUTE FORMULA($myFormula)))
					
					READ ONLY:C145($tablePtr->)
					
				End if 
			End if 
		End if 
		
	Else 
		
		bModifyLlistBoxRecords($tablePtr)
		
		UTIL_unloadAllRecords($tablePtr)  // make sure nothing is locked
	End if 
	
	REDRAW:C174(mainListBox)
End if 


