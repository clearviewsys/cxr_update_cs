//%attributes = {}
// bModifyListBoxRecords ({->[table]})

C_POINTER:C301($tablePtr; $1)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
If (Not:C34(Is nil pointer:C315($tablePtr)))
	
	Case of 
		: (Form event code:C388=On Load:K2:1)
			enableButtonIf(isUserAuthorizedToModify(Current form table:C627); "ChangeButton")
			enableButtonIf(isEditButtonDisabledForTable($tablePtr); "ChangeButton")
			
		: (Form event code:C388=On Clicked:K2:4)
			
			C_TEXT:C284($highlightSet; $storageSet)
			$highlightSet:=getMainListBoxSetName($tablePtr)
			If (Records in set:C195($highlightSet)>0)  // if more than 1 record is selected
				COPY SET:C600($highlightSet; $storageSet)
				
				editRecordTable($tablePtr)
				
				COPY SET:C600($storageSet; $highlightSet)
				CLEAR SET:C117($storageSet)
			End if 
	End case 
End if 
