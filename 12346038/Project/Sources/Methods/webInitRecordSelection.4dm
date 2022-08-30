//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 11/22/18, 07:36:38
// ----------------------------------------------------
// Method: webInitRecordSelection
// Description
//     make sure there are no current records to be processed by 4D tags
//
// Parameters
// ----------------------------------------------------


// --- start off with no selections ----
READ ONLY:C145(*)
C_LONGINT:C283($i)
For ($i; 1; Get last table number:C254)
	If (Is table number valid:C999($i))
		REDUCE SELECTION:C351(Table:C252($i)->; 0)
	End if 
End for 
