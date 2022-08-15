If (Form event code:C388=On Load:K2:1)
	
	ARRAY BOOLEAN:C223(arrListBox; 0)
	ARRAY LONGINT:C221(arrIDs; 0)
	ARRAY DATE:C224(arrDates; 0)
	ARRAY TEXT:C222(arrDevelopers; 0)
	ARRAY TEXT:C222(arrSubjects; 0)
	ARRAY TEXT:C222(arrComments; 0)
	ARRAY TEXT:C222(arrSourceCodes; 0)
	C_TEXT:C284(vSourceCode)
	vSourceCode:=""
	C_TEXT:C284(vMergedCode)
	vMergedCode:=""
	
	handleViewVersionHistoryButton
End if 

If (Form event code:C388=On Outside Call:K2:11)
	handleViewVersionHistoryButton
	vSourceCode:=""
End if 

handleViewFormMethod