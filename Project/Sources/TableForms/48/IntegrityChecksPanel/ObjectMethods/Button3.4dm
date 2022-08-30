CONFIRM:C162("This will delete all previous integrity checks!")
If (OK=1)
	READ WRITE:C146([IC_FailedRecords:49])  //6/29/16
	ALL RECORDS:C47([IC_FailedRecords:49])
	DELETE SELECTION:C66([IC_FailedRecords:49])
	READ ONLY:C145([IC_FailedRecords:49])  //6/29/16
	REDRAW WINDOW:C456
End if 