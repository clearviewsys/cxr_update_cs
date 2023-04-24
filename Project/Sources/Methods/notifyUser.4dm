//%attributes = {}
// notifyUser(message; doBeep)

C_TEXT:C284($1)
C_BOOLEAN:C305($2)

If ($2)
	BEEP:C151
End if 

If ($1#"")
	//ALERT($1)

End if 
