//%attributes = {}
// ------------------------------------------------------------------------------
// Method: GAMLGenerateReport
// Generate the XML File for GoAML Platform
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 8/7/2016
// ------------------------------------------------------------------------------

checkInit

// Get all transactions in the date range depending on the report type
GAML_GetPTRTransactions

If (isValidationConfirmed)
	GAML_GenerateGoAMLReport
End if 

GAML_GetPTRTransactions

