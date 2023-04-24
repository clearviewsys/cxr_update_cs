//%attributes = {}
// isUserAnAgent (userID)
// returns true if user is an agent

C_TEXT:C284($1; $userID)
C_LONGINT:C283($n)

C_BOOLEAN:C305($0)
$userID:=$1

SET QUERY DESTINATION:C396(Into variable:K19:4; $n)
QUERY:C277([Agents:22]; [Agents:22]AgentID:1=$1)
If ($n=1)  // if found
	$0:=True:C214
Else 
	$0:=False:C215
End if 

SET QUERY DESTINATION:C396(Into current selection:K19:1)
