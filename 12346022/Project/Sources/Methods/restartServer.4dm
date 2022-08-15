//%attributes = {"shared":true}
C_LONGINT:C283($processID)

CONFIRM:C162("Are you sure you want to restart the server?")
If (OK=1)
	$processID:=Execute on server:C373("restartClient"; 32000)
End if 