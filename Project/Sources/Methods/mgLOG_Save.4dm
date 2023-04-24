//%attributes = {}
// saves MG Log locally

C_BOOLEAN:C305($1; $clearLog)
C_TEXT:C284($logfile; $json; $gmt)

$clearLog:=True:C214

If (Count parameters:C259>0)
	$clearLog:=$1
End if 

$gmt:=String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178)
$gmt:=Replace string:C233($gmt; ":"; "_")
$logfile:=System folder:C487(Documents folder:K41:18)+"mgLOG_"+$gmt+".json"

$json:=mgLOG_GetJSON

TEXT TO DOCUMENT:C1237($logfile; $json; "UTF-8")

If ($clearLog)
	mgLOG_Clear
End if 

