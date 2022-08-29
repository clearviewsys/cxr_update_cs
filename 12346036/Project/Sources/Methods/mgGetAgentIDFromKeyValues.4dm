//%attributes = {}
// returns a collection of deviceIDs to be used in MoneyGram credentials
C_COLLECTION:C1488($0; $deviceIDs)
C_TEXT:C284($prefix; $deviceIDsString)

$prefix:="mg."+getBranchID+"."
$deviceIDsString:=getKeyValue($prefix+"agentID")

ARRAY TEXT:C222($devices; 0)

STR_SplitToArray($deviceIDsString; ";"; ->$devices)

If (Size of array:C274($devices)>0)
	$deviceIDs:=New collection:C1472
	ARRAY TO COLLECTION:C1563($deviceIDs; $devices)
End if 

$0:=$deviceIDs
