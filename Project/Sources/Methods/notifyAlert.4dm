//%attributes = {}
// notifyAlert (title; message; { duration})
C_TEXT:C284($1)  //title
C_TEXT:C284($2)  //message
C_LONGINT:C283($3)  //duration in seconds

If (Not:C34(isScreenLocked))  // we don't require warnings and notifications when the screen is locked
	
	Case of 
		: (Count parameters:C259=3)
			iH_Notify($1; $2; $3)
			
		: (Count parameters:C259=2)
			iH_Notify($1; $2)
			
		: (Count parameters:C259=1)
			iH_Notify("Notification"; $1)
			
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 
	
End if 