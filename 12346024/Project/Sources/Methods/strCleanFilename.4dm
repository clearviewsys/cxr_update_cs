//%attributes = {}
C_TEXT:C284($1; $tFilename)

C_TEXT:C284($0)


$tFilename:=$1

$tFilename:=Replace string:C233($tFilename; " "; "_")  //replace spaces
$tFilename:=Replace string:C233($tFilename; "/"; "")
$tFilename:=Replace string:C233($tFilename; "\\"; "")
$tFilename:=Replace string:C233($tFilename; "&"; "")
$tFilename:=Replace string:C233($tFilename; "#"; "")

$0:=$tFilename