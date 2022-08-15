// handleSaveWireButton 
// this method is called from the save button for PAY/RECEIVE forms in [WireS]
checkInit
validateeWires

If (isValidationConfirmed)
	If ([eWires:13]Author:4="")
		[eWires:13]Author:4:=Current user:C182
	End if 
	If ([eWires:13]AgentID:26="")
		[eWires:13]AgentID:26:=[Links:17]AuthorizedUser:13
	End if 
	If ([eWires:13]CustomerID:15="")
		[eWires:13]CustomerID:15:=[Links:17]CustomerID:14
		[eWires:13]SenderName:7:=[Links:17]CustomerName:15
		
	End if 
	
	createRegisterOfeWire
Else 
	REJECT:C38
End if 