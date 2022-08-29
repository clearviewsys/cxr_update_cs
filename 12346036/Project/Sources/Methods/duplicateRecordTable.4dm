//%attributes = {}
// duplicateRecordTable (->table;->fieldToDuplicate;Name of Field)
// e.g. duplicateRecordTable (->[Currencies];->[Currencies]CurrencyCode;"Currency Alias")

C_POINTER:C301($tablePtr; $1)
C_POINTER:C301($fieldPtr; $2)
C_TEXT:C284($fieldName; $3)

$tablePtr:=$1
$fieldPtr:=$2
$fieldName:=$3

C_TEXT:C284($oldAccountName; $newAccountName)

If (isUserAuthorizedToAddRecord($tablePtr))
	READ WRITE:C146($tablePtr->)
	If (Records in selection:C76($tablePtr->)=1)
		LOAD RECORD:C52($tablePtr->)
		$oldAccountName:=$fieldPtr->
		Repeat 
			$newAccountName:=Request:C163("New value for "+$fieldName+" "+$oldAccountName+": "; $oldAccountName; "Save"; "Cancel")
			If ($oldAccountName=$newAccountName)
				myAlert("You cannot use the same "+$fieldName+"!")
			End if 
		Until (($newAccountName#$oldAccountName) | (OK=0))
		If (OK=1)
			DUPLICATE RECORD:C225($tablePtr->)
			$fieldPtr->:=$newAccountName
			C_LONGINT:C283($j)
			//need to blank any _Sync_ID fields here
			For ($j; 1; Get last field number:C255($tablePtr))
				If (Is field number valid:C1000($tablePtr; $j))
					If (Field name:C257(Table:C252($tablePtr); $j)="_Sync_ID")
						Field:C253(Table:C252($tablePtr); $j)->:=""  //reset syncID to blank
					End if 
					
					If (Field name:C257(Table:C252($tablePtr); $j)="_Sync_Data")
						SET BLOB SIZE:C606(Field:C253(Table:C252($tablePtr); $j)->; 0)  //reset sync data to blank
					End if 
				End if 
			End for 
			
			
			SAVE RECORD:C53($tablePtr->)
			//UNLOAD RECORD($tablePtr->)
		End if 
	Else 
		myAlert("Please select 1 record only (filter) to duplicate.")
	End if 
	READ ONLY:C145($tablePtr->)
Else 
	myAlert("You are not authorized to add or duplicate record to this module.")
End if 