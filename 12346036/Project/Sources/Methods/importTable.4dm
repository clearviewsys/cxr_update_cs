//%attributes = {}
// importRecords (->[TABLE])

C_POINTER:C301($tablePtr; $1)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

disableTriggers
If (Not:C34(Is nil pointer:C315($tablePtr)))
	ALL RECORDS:C47($tablePtr->)
	If (Records in selection:C76($tablePtr->)>0)
		CONFIRM:C162("There are still "+String:C10(Records in selection:C76($tablePtr->))+" record(s) in table "+Table name:C256($tablePtr); "Delete all"; "Leave it")
		If (OK=1)
			DELETE SELECTION:C66($tablePtr->)
		End if 
	End if 
	ImportExportTable($tablePtr; True:C214)
	enableTriggers
End if 