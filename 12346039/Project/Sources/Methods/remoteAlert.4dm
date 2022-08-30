//%attributes = {"shared":true}
C_TEXT:C284($1; $tParam)

//C_TEXT($0)
C_OBJECT:C1216($0; $status)

$status:=New object:C1471



If (Count parameters:C259>=1)
	$tParam:=$1
Else 
	$tParam:=""
End if 

If (SOAP Request:C783)
	ARRAY TEXT:C222($asclients; 0)
	ARRAY LONGINT:C221($aiMethods; 0)
	GET REGISTERED CLIENTS:C650($asclients; $aiMethods)
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($asclients))
		EXECUTE ON CLIENT:C651($asclients{$i}; "remoteAlert"; $tParam)
	End for 
Else 
	myAlert($tParam)
End if 

$status.success:=True:C214
$status.statusText:="Alert Sent"

$0:=$status