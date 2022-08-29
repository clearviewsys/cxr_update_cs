//%attributes = {}
// getAgentSettledAccountID (agentID; isPayable;currency)
// this method is called from [eWires]PayReceive form



C_TEXT:C284($agentID; $1; $3; $currency; $accountID; $0)
C_BOOLEAN:C305($2; $isPayable)
$agentID:=$1
$isPayable:=$2
$currency:=$3

QUERY:C277([Accounts:9]; [Accounts:9]isSettlementAccount:25=True:C214; *)  // this is changed in version 3.452 - used to look for mainaccount= c_payable
QUERY:C277([Accounts:9];  & ; [Accounts:9]AgentID:16=$agentID; *)
QUERY:C277([Accounts:9];  & ; [Accounts:9]Currency:6=$currency)

If ($isPayable)
	If (Records in selection:C76([Accounts:9])=0)
		$accountID:=makeeWirePayable($currency)
	Else 
		$accountID:=[Accounts:9]AccountID:1
	End if 
Else 
	If (Records in selection:C76([Accounts:9])=0)
		$accountID:=makeeWireReceivable($currency)
	Else 
		$accountID:=[Accounts:9]AccountID:1
	End if 
End if 

$0:=$accountID