//%attributes = {}
C_TEXT:C284($1; $agentID)
C_LONGINT:C283($0; $count)

$agentID:=$1

SET QUERY DESTINATION:C396(Into variable:K19:4; $count)

QUERY:C277([eWires:13]; [eWires:13]isPaymentSent:20=False:C215; *)
QUERY:C277([eWires:13];  & ; [eWires:13]isSettled:23=False:C215; *)
QUERY:C277([eWires:13];  & ; [eWires:13]isCancelled:34=False:C215; *)
QUERY:C277([eWires:13];  & ; [eWires:13]AgentID:26=$agentID)

SET QUERY DESTINATION:C396(Into current selection:K19:1)
$0:=$count