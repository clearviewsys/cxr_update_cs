If (Form event code:C388=On Data Change:K2:15)
	
	C_POINTER:C301($tablePtr)
	$tablePtr:=getAMLDashboardTabTablePtr  // returns the pointer to the table
	handleSearchArea($tablePtr)  // search that table
	GOTO OBJECT:C206(*; "vSearchString")
End if 