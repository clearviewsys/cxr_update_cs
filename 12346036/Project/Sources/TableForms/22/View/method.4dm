handleViewForm

//C_INTEGER(tabAgentsView)

Case of 
	: (tabAgentsView=1)
		// ACCOUNTS
		READ ONLY:C145([Accounts:9])
		QUERY:C277([Accounts:9]; [Accounts:9]AgentID:16=[Agents:22]AgentID:1)
		
	: (tabAgentsView=2)
		// Links
		READ ONLY:C145([Links:17])
		QUERY:C277([Links:17]; [Links:17]AuthorizedUser:13=[Agents:22]AgentID:1)
		
	: (tabAgentsView=3)
		QUERY:C277([eWires:13]; [eWires:13]AgentID:26=[Agents:22]AgentID:1; *)
		QUERY:C277([eWires:13];  & ; [eWires:13]isPaymentSent:20=True:C214)
		orderByeWires
		
	: (tabAgentsView=4)
		QUERY:C277([eWires:13]; [eWires:13]AgentID:26=[Agents:22]AgentID:1; *)
		QUERY:C277([eWires:13];  & ; [eWires:13]isPaymentSent:20=False:C215)
		orderByeWires
		
End case 