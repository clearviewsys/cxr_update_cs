//%attributes = {}
C_TEXT:C284($1; $agentID)
C_LONGINT:C283($0; $count)

$agentID:=$1

SET QUERY DESTINATION:C396(Into variable:K19:4; $count)

QUERY:C277([MESSAGES:11]; [MESSAGES:11]isUnlisted:13=False:C215; *)
QUERY:C277([MESSAGES:11];  & ; [MESSAGES:11]toUserID:6=$agentID)

SET QUERY DESTINATION:C396(Into current selection:K19:1)
$0:=$count