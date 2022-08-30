//%attributes = {}
// stringContains (string; lookupstring): boolean
// returns true iff the string contains the lookupstring


C_TEXT:C284($str; $lookupStr; $1; $2)

$lookupStr:=$2
$str:=$1

If (Position:C15($lookupStr; $str)>0)
	$0:=True:C214
Else 
	$0:=False:C215
End if 
