//%attributes = {}
// IdentityMind_handleHttpError
// Shows an time out error alert
//
// Paramters: (NONE)
//
// Return: (NONE)

// Method is being use for ON ERR CALL in IdentityMind_httpRequest

If (IdentityMindStage#"edna")
	ARRAY LONGINT:C221($codesArray; 0)
	ARRAY TEXT:C222($intCompArray; 0)
	ARRAY TEXT:C222($textArray; 0)
	GET LAST ERROR STACK:C1015($codesArray; $intCompArray; $textArray)
	TRACE:C157
End if 