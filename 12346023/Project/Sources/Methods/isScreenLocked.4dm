//%attributes = {}
// isScreenLocked
// returns true if the screen is locked

C_BOOLEAN:C305($0)

If (getApplicationUser="LOCKED")
	$0:=True:C214
Else 
	$0:=False:C215
End if 