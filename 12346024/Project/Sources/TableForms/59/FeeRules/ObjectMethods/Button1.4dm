C_LONGINT:C283($i)

READ WRITE:C146([FeeRules:59])
ALL RECORDS:C47([FeeRules:59])
FIRST RECORD:C50([FeeRules:59])
UNLOAD RECORD:C212([FeeRules:59])
DELETE SELECTION:C66([FeeRules:59])


For ($i; 1; LISTBOX Get number of rows:C915(feeRulesListBox))
	CREATE RECORD:C68([FeeRules:59])
	
	setFeeRulesFieldsToLBColumnVars($i)
	
	SAVE RECORD:C53([FeeRules:59])
	UNLOAD RECORD:C212([FeeRules:59])
End for 
READ ONLY:C145([FeeRules:59])
POST OUTSIDE CALL:C329(Current process:C322)  // update the table



//ACCEPT

