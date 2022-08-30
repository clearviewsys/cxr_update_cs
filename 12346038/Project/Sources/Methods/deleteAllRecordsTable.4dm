//%attributes = {}
// deleteAllRecordsTable (->table)
// this method only can be triggered by superadmin

C_POINTER:C301($tablePtr; $1)
Case of 
	: (Count parameters:C259=0)
		$tablePtr:=->[Industries:114]
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (isUserSuperAdmin)
	CONFIRM:C162("Are you sure you want to delete all records in table "+Table name:C256($tablePtr); "NO"; "Yes")
	If (OK=0)  // If yes is selected we delete, which is not the default state
		READ WRITE:C146($tablePtr->)
		ALL RECORDS:C47($tablePtr->)
		C_LONGINT:C283($n)
		$n:=Records in selection:C76($tablePtr->)
		
		DELETE SELECTION:C66($tablePtr->)
		READ ONLY:C145($tablePtr->)
		myAlert("<X> records Deleted from table <Y>"; "Alert"; String:C10($n); Table name:C256($tablePtr))
	Else 
		myAlert("No records deleted from table <X>!"; "Good news"; Table name:C256($tablePtr))
	End if 
	
End if 
