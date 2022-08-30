//%attributes = {}
//handleDeleteRows(->subtable)
// use this method in a button that deletes subtable records
C_POINTER:C301($1)

GET HIGHLIGHTED RECORDS:C902($1->; "$highlight")
If (Records in set:C195("$highlight")>0)
	CONFIRM:C162("Are you sure you want to delete "+String:C10(Records in set:C195("$highlight"))+" record(s) ?")
	If (OK=1)
		USE SET:C118("$highlight")
		DELETE SELECTION:C66($1->)
	End if 
Else 
	myAlert("Please select the line(s) to be deleted.")
End if 
CLEAR SET:C117("$highlight")
POST OUTSIDE CALL:C329(-1)  // update the display