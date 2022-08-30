//%attributes = {"publishedWeb":true}
// deletedHighlightedRecords(->table;{setName})
//
// Mehtod to call when multiple or single selection are to be deleted

C_POINTER:C301($1; $tablePtr)
C_TEXT:C284($2; $setName)

Case of 
	: (Count parameters:C259=1)
		$tablePtr:=$1
		$setName:="UserSet"
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$setName:=$2
	Else 
		$tablePtr:=Current form table:C627
		$setName:="UserSet"
End case 
If (Not:C34(Is nil pointer:C315($tablePtr)))
	
	If (isUserAuthorizedToDelete($tablePtr))
		If (Records in set:C195($setName)=0)
			myAlert("Please select the records you want to delete.")
		Else 
			
			myConfirm("Delete the "+String:C10(Records in set:C195($setName))+" selected record(s)?"; "No"; "Yes")
			If (OK=0)  //the user clicked Yes
				CREATE SET:C116($tablePtr->; "$selection")
				DIFFERENCE:C122("$selection"; $setName; "$selectionDeleted")
				USE SET:C118($setName)
				checkInit
				executeMethodName("delChecks"+Table name:C256($tablePtr))
				If (isValidationConfirmed)
					//ON ERR CALL("nilErrorTrap")
					executeMethodName("delete"+Table name:C256($tablePtr))
					//ON ERR CALL("")
					
					READ WRITE:C146($tablePtr->)  // 
					DELETE SELECTION:C66($tablePtr->)
					USE SET:C118("$selectionDeleted")  // resore to the selection selection without the deleted records 
					
					If (Records in set:C195("LockedSet")>0)
						USE SET:C118("LockedSet")
						myAlert("Some records were locked and may not have been deleted. Try restarting the program if the problem persists.")
					End if 
				Else 
					USE SET:C118("$selection")  // restore to the original selection
				End if 
				CLEAR SET:C117("$selection")
				CLEAR SET:C117("$selectionDeleted")
				executeMethodName("orderBy"+Table name:C256($tablePtr))
			End if 
		End if 
	Else 
		myAlert_AccessDenied
	End if 
End if 