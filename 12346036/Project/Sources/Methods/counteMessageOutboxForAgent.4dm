//%attributes = {}
C_TEXT:C284($1; $agentID)
C_LONGINT:C283($0; $count)

$agentID:=$1

SET QUERY DESTINATION:C396(Into variable:K19:4; $count)

QUERY:C277([MESSAGES:11]; [MESSAGES:11]isMessageSent:14=False:C215; *)
QUERY:C277([MESSAGES:11];  & ; [MESSAGES:11]isRead:12=False:C215; *)
QUERY:C277([MESSAGES:11];  & ; [MESSAGES:11]FromUserID:5=$agentID)

SET QUERY DESTINATION:C396(Into current selection:K19:1)
$0:=$count