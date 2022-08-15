checkInit

checkAddWarning("Are you sure you want to cancel?")

If (isValidationConfirmed)
	CANCEL TRANSACTION:C241
	
	TM_RemoveFromStack  //9/15/16
	
	CANCEL:C270
	
Else 
	REJECT:C38
End if 

