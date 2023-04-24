//%attributes = {}
C_COLLECTION:C1488($1; $log)
C_TEXT:C284($logfile; $json; $gmt; $docfolder)

$log:=$1

$gmt:=String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178)
$gmt:=Replace string:C233($gmt; ":"; "_")

$docfolder:=System folder:C487(Documents folder:K41:18)

If (Test path name:C476($docfolder+"mgLOGs")=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($docfolder+"mgLOGs")
End if 

$logfile:=$docfolder+Folder separator:K24:12+"mgProfixLOG_"+$gmt+".json"

$json:=JSON Stringify:C1217($log; *)

TEXT TO DOCUMENT:C1237($logfile; $json; "UTF-8")
