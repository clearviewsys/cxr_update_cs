//%attributes = {}
// checkAddErrorOnTrue(boolean isError;errorString)

C_BOOLEAN:C305($1)
C_TEXT:C284($2)

If ($1)
	checkAddError($2)
Else 
	checkAddWarning($2)
End if 