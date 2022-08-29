

Case of 
	: (Trigger event:C369=On Saving New Record Event:K3:1)
		
		If ([WebEWireLogs:151]creationDate:2=!00-00-00!)
			[WebEWireLogs:151]creationDate:2:=Current date:C33
			[WebEWireLogs:151]creationTime:3:=Current time:C178
		End if 
		
		
	: (Trigger event:C369=On Saving Existing Record Event:K3:2)
		
		
	: (Trigger event:C369=On Deleting Record Event:K3:3)
		
		
End case 