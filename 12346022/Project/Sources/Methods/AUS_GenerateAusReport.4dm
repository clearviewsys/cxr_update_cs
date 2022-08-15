//%attributes = {}
// Method: AUS_GenerateAusReport

checkInit

// Get all transactions in the date range depending on the report type
//AUS_GetAusTransactions 

If (isValidationConfirmed)
	AUS_GenerateAusFinalReport
End if 

//AUS_GetAusTransactions 


