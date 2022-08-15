//%attributes = {}
// createServerPrefs
C_LONGINT:C283($WinRef)
READ ONLY:C145([ServerPrefs:27])
ALL RECORDS:C47([ServerPrefs:27])
If (Records in selection:C76([ServerPrefs:27])=0)
	READ WRITE:C146([ServerPrefs:27])
	FORM SET INPUT:C55([ServerPrefs:27]; "Preferences")
	$WinRef:=Open form window:C675([ServerPrefs:27]; "Preferences"; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4; *)
	ADD RECORD:C56([ServerPrefs:27]; *)
	
	UNLOAD RECORD:C212([ServerPrefs:27])
	READ ONLY:C145([ServerPrefs:27])
Else 
	READ ONLY:C145([ServerPrefs:27])
	FIRST RECORD:C50([ServerPrefs:27])
	LOAD RECORD:C52([ServerPrefs:27])
	
	
	UNLOAD RECORD:C212([ServerPrefs:27])
End if 

