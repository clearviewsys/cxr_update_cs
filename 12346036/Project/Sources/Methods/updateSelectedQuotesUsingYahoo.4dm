//%attributes = {"publishedWeb":true}
FIRST RECORD:C50([Currencies:6])
C_TEXT:C284(vHTML)

C_LONGINT:C283($winRef; $i)

CREATE EMPTY SET:C140([Currencies:6]; "FailedUpdate")
READ WRITE:C146([Currencies:6])

For ($i; 1; Records in selection:C76([Currencies:6]))
	LOAD RECORD:C52([Currencies:6])
	If (updateSpotRate)
		SAVE RECORD:C53([Currencies:6])  // save the changes
	Else 
		ADD TO SET:C119([Currencies:6]; "FailedUpdate")
	End if 
	NEXT RECORD:C51([Currencies:6])
End for 

UNLOAD RECORD:C212([Currencies:6])
READ ONLY:C145([Currencies:6])

HIGHLIGHT RECORDS:C656([Currencies:6]; "FailedUpdate")
CLEAR SET:C117("FailedUpdate")
