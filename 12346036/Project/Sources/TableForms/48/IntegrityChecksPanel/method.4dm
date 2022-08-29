C_LONGINT:C283(vTotalFailedRecords; cbApplyDateRange)
C_DATE:C307(vFromDate; vToDate)

If (Form event code:C388=On Load:K2:1)
	//SET TIMER(120)
	fillIntegrityCheckArrays
	allRecordsIC_FailedRecords
End if 

//If (Form event=On Timer )
//allRecordsIC_FailedRecords 
//vTotalFailedRecords:=Records in selection([IC_FailedRecords])
//REDRAW WINDOW
//End if 
//vTotalFailedRecords:=Records in selection([IC_FailedRecords])
