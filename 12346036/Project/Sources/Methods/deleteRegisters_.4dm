//%attributes = {}
checkInit
If (Not:C34(isUserAuthorizedToDelete(->[Registers:10])))
	checkAddError("Sorry you are not allowed to delete any record from this table.")
End if 

CREATE SET:C116([Registers:10]; "$selection")
DIFFERENCE:C122("$selection"; "UserSet"; "$selection")
USE SET:C118("UserSet")
If (Records in selection:C76([Registers:10])>1)
	checkAddError("Sorry, you can only delete one register at a time")
End if 

If (isValidationConfirmed)
	READ WRITE:C146([Registers:10])
	C_POINTER:C301($tablePtr)
	If ([Registers:10]InternalTableNumber:17>0)
		$tablePtr:=Table:C252([Registers:10]InternalTableNumber:17)
		If (Table:C252($tablePtr)#Table:C252(->[Registers:10]))
			READ WRITE:C146($tablePtr->)  // delete the related ewire or other table
			
			QUERY:C277($tablePtr->; Field:C253([Registers:10]InternalTableNumber:17; 1)->=[Registers:10]InternalRecordID:18)  // find the related ewire
			
			DELETE RECORD:C58($tablePtr->)
			myAlert("Record "+[Registers:10]InternalRecordID:18+" deleted from "+getElegantTableName($tablePtr))
			READ ONLY:C145($tablePtr->)
		End if 
	End if 
	DELETE RECORD:C58([Registers:10])
	
	
	
	If (Records in set:C195("LockedSet")>0)
		USE SET:C118("LockedSet")
		myAlert("Some records were locked and may be still active.")
	End if 
End if 

USE SET:C118("$selection")
CLEAR SET:C117("$selection")