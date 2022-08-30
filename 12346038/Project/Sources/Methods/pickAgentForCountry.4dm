//%attributes = {}
C_POINTER:C301($1)
C_TEXT:C284($country; $2)
$country:=$2

QUERY:C277([Agents:22]; [Agents:22]Country:5=$country)

If (Records in selection:C76([Agents:22])>0)
	pickRecordForTable(->[Agents:22]; ->[Agents:22]AgentID:1; $1; True:C214)
Else 
	myAlert("No agents to pick from in "+$country)
End if 