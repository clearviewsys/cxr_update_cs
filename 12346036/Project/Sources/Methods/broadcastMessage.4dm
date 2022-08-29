//%attributes = {}

C_TEXT:C284($1)  //title
C_TEXT:C284($2)  //message
C_LONGINT:C283($3)  //duration

If (Count parameters:C259>=3)
	iH_Broadcast($1; $2; $3)
Else 
	iH_Broadcast($1; $2)
End if 