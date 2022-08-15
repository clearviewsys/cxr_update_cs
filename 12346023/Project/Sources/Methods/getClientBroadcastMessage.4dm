//%attributes = {}
C_TEXT:C284($broadcast; $0)
$broadcast:=""

If (<>clientCode#"")
	$broadcast:=ws_getKeyValueAsText(<>clientCode; <>clientKey; "dispatchMessage")
End if 

If ($broadcast#"")
	$0:=$broadcast
End if 
