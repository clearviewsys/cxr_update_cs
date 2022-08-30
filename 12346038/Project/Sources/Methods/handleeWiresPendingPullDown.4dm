//%attributes = {}
C_POINTER:C301($self)
$self:=->arrAgents
C_TEXT:C284($agentID)

If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222($self->; 0)
	ARRAY TEXT:C222(arrDirections; 3)
	
	allRecordsAgents
	
	SELECTION TO ARRAY:C260([Agents:22]AgentID:1; $self->)
	INSERT IN ARRAY:C227($self->; 1)
	$Self->{1}:="All Agents"
	$Self->:=1
End if 

If (Form event code:C388=On Clicked:K2:4)
	$agentID:=$Self->{$Self->}
	
	If ($Self->=1)  // all agents
		
		Case of 
			: (arrDirections=1)  // both way
				selectEwiresPendingByAgent
			: (arrDirections=2)  // eWires Pending Sent
				selectEWiresSentPendingByAgent
			: (arrDirections=3)  // eWires Pending Received
				selecteWireRcvdPendingByAgent
		End case 
	Else   // only a particular agent
		Case of 
			: (arrDirections=1)  // both way
				selectEwiresPendingByAgent($agentID)
			: (arrDirections=2)  // eWires Pending Sent
				selectEWiresSentPendingByAgent($agentID)
			: (arrDirections=3)  // eWires Pending Received
				selecteWireRcvdPendingByAgent($agentID)
		End case 
		
		
	End if 
	orderByeWires
	//ewr_filleWiresListBox 
	POST OUTSIDE CALL:C329(Current process:C322)
	
End if 

