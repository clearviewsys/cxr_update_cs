//%attributes = {}
// Records Delete
// Mehtod to call when multiple or single selection are to be deleted

If (Records in set:C195("UserSet")=0)
	BEEP:C151
	myAlert("Please highlight the record(s) you want to delete first.")
Else 
	BEEP:C151
	
	CONFIRM:C162("Delete the "+String:C10(Records in set:C195("UserSet"))+" selected record(s)?"; "No"; "Yes")
	If (OK=0)  //the user clicked Yes
		CREATE SET:C116(Current form table:C627->; "$selection")
		DIFFERENCE:C122("$selection"; "UserSet"; "$selection")
		USE SET:C118("UserSet")
		DELETE SELECTION:C66(Current form table:C627->)
		USE SET:C118("$selection")
		CLEAR SET:C117("$selection")
	End if 
End if 