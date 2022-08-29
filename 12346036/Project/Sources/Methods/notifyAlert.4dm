//%attributes = {}
// notifyAlert (title; message; { duration})

C_TEXT:C284($1)  //title
C_TEXT:C284($2)  //message
C_LONGINT:C283($3)  //duration in seconds

If (Not:C34(isScreenLocked))  // we don't require warnings and notifications when the screen is locked
	If (Count parameters:C259>=3)
		iH_Notify($1; $2; $3)
	Else 
		iH_Notify($1; $2)
	End if 
End if 