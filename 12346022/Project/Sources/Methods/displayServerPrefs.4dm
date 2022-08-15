//%attributes = {"shared":true}
If (isUserAdministrator)
	ALL RECORDS:C47([ServerPrefs:27])
	FIRST RECORD:C50([ServerPrefs:27])
	READ WRITE:C146([ServerPrefs:27])
	
	C_LONGINT:C283($winref)
	$WinRef:=Open form window:C675([ServerPrefs:27]; "Preferences"; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4; *)
	MODIFY RECORD:C57([ServerPrefs:27]; *)
	UNLOAD RECORD:C212([ServerPrefs:27])
	READ ONLY:C145([ServerPrefs:27])
	
	CLOSE WINDOW:C154
Else 
	myAlert_AdminPrivilegeNeeded
End if 
