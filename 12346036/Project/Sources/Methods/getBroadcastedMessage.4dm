//%attributes = {}
C_TEXT:C284($message; $0)
$message:=ws_getKeyValueAsText("_system"; "_donotchange"; "broadcastmessage")
If (Length:C16($message)>2)
	$0:=$message
Else 
	$0:=""
End if 