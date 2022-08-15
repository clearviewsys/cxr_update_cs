C_TEXT:C284($notes)

checkInit
If (Size of array:C274(arrCurr)<1)
	checkAddError("Table is empty")
End if 

If (isValidationConfirmed)
	
	$notes:=""
	
	saveOrderLines(0; $notes)
	SAVE RECORD:C53([Orders:95])
	
Else 
	BEEP:C151
	REJECT:C38
End if 
