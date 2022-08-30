//%attributes = {"shared":true}
C_TEXT:C284($text)

$text:=getClientBroadcastMessage

$text:=Request:C163("Set the startup message"; $text; "Set Broadcast Message"; "Cancel")

If (OK=1)
	setClientBroadcastMessage($text)
End if 


