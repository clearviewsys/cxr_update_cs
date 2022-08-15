//%attributes = {}
// Method: FJ_GenerateFijiReport

checkInit

// Get all transactions in the date range depending on the report type
FJ_GetFijiTransactions

If (isValidationConfirmed)
	FJ_GenerateFijiFinalReport
End if 

FJ_GetFijiTransactions

