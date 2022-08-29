
//setEnterableIff (isForeignAccount;"AuthorizedUser@")

If ([Accounts:9]isForeignAccount:15=True:C214)
	GOTO OBJECT:C206([Accounts:9]AgentID:16)
	
Else 
	[Accounts:9]AgentID:16:=""
	UNLOAD RECORD:C212([Agents:22])
	
End if 


