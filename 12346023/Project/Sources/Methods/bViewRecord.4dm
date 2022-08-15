//%attributes = {"publishedWeb":true}
// bViewRecord

C_LONGINT:C283($i)

If (isUserAuthorizedToView(Current form table:C627))
	USE SET:C118("UserSet")
	// iterate through records and open each one 
	
	READ ONLY:C145(Current form table:C627->)
	FIRST RECORD:C50(Current form table:C627->)
	For ($i; 1; Records in selection:C76(Current form table:C627->))
		COPY NAMED SELECTION:C331(Current form table:C627->; getTableNamedSelection(Current form table:C627))
		displayRecord(Current form table:C627; $i)
		DELAY PROCESS:C323(Current process:C322; 50)  // this line is problematic
		
	End for 
Else 
	myAlert_AccessDenied
End if 