//%attributes = {}
C_TEXT:C284($agentID; $1)

Case of 
	: (Count parameters:C259=1)
		$agentID:=$1
	Else 
		$agentID:="@"  // all
End case 

QUERY:C277([eWires:13]; [eWires:13]AgentID:26=$agentID; *)  // select by agent
QUERY:C277([eWires:13];  & ; [eWires:13]isPaymentSent:20=True:C214; *)  // payment sent
QUERY:C277([eWires:13];  & ; [eWires:13]isSettled:23=False:C215; *)  // pending
QUERY:C277([eWires:13];  & [eWires:13]isCancelled:34=False:C215)  // not cancelled
