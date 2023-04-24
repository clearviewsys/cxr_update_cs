//%attributes = {}
// gets MoneyGram Profix credentials from KeyValues

C_OBJECT:C1216($0; $credentials)
C_TEXT:C284($agentID; $password; $username; $prefix)
C_COLLECTION:C1488($deviceIDs)

$prefix:="mg."+getBranchID+"."

$deviceIDs:=mgGetAgentIDFromKeyValues

If ($deviceIDs#Null:C1517)
	If ($deviceIDs.length>0)
		$agentID:=$deviceIDs[0]
	End if 
End if 

If ($agentID="")
	$agentID:=getKeyValue($prefix+"agentID")
End if 

$username:=getKeyValue($prefix+"username")
$password:=getKeyValue($prefix+"password")

$credentials:=New object:C1471("username"; $username; "agentID"; $agentID; "password"; $password)
$credentials.deviceIDs:=$deviceIDs

$0:=$credentials
