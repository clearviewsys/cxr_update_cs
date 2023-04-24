//%attributes = {}
//handleDeleteRows(->subtable)
// use this method in a button that deletes subtable records
C_POINTER:C301($1)
LOAD RECORD:C52($1->)
If (Record number:C243($1->)>=0)
	CONFIRM:C162("Are you sure you want to delete the row?")
	If (OK=1)
		DELETE RECORD:C58($1->)
	End if 
Else 
	myAlert("Please select the line(s) to be deleted.")
End if 
