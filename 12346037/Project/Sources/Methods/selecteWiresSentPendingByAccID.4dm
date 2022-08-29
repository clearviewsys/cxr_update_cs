//%attributes = {}
// selecteWireSentPendingByAccID ( {agentId {; accountID} } )
// selects all ewires that were sent and are pending and have not been 

C_TEXT:C284($accountID; $agentID; $1; $2)


Case of 
	: (Count parameters:C259=1)
		$agentID:=$1
	: (Count parameters:C259=2)
		$agentID:=$1
		$accountID:=$2
	Else 
		$agentID:="@"
		$accountID:="@"  // all
End case 

QUERY:C277([eWires:13]; [eWires:13]AgentID:26=$agentID; *)  // select by agent
QUERY:C277([eWires:13];  & ; [eWires:13]AccountID:30=$accountID; *)  // select by account

QUERY:C277([eWires:13];  & ; [eWires:13]isPaymentSent:20=True:C214; *)  // payment sent
QUERY:C277([eWires:13];  & ; [eWires:13]isSettled:23=False:C215; *)  // pending
QUERY:C277([eWires:13];  & [eWires:13]isCancelled:34=False:C215)  // not cancelled
