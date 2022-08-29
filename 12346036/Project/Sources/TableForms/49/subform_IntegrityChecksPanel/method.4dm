If (Form event code:C388=On Display Detail:K2:22)
	If ([IC_FailedRecords:49]tableNo:2>0)
		vTableName:=Table name:C256([IC_FailedRecords:49]tableNo:2)
	Else 
		vTableName:=""
	End if 
End if 


//handleListForm 
If (Form event code:C388=On Double Clicked:K2:5)
	C_POINTER:C301($tablePtr)
	C_TEXT:C284($recordID)
	
	If (Selected record number:C246([IC_FailedRecords:49])>0)
		LOAD RECORD:C52([IC_FailedRecords:49])
		$tablePtr:=Table:C252([IC_FailedRecords:49]tableNo:2)
		$recordID:=[IC_FailedRecords:49]recordID:3
		queryByID($tablePtr; $recordID)
		
		displaySelectedRecords($tablePtr)
		FILTER EVENT:C321
	End if 
	
End if 