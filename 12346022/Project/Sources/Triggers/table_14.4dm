C_LONGINT:C283($0)

$0:=0  //Assume the database request will be granted
If (isTriggerEnabled)
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			If ([WebUsers:14]creationDate:13=!00-00-00!)
				[WebUsers:14]creationDate:13:=Current date:C33
				[WebUsers:14]creationTime:14:=Current time:C178
			End if 
			[WebUsers:14]Email:3:=strRemoveSpaces([WebUsers:14]Email:3)
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[WebUsers:14]Email:3:=strRemoveSpaces([WebUsers:14]Email:3)
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
	End case 
End if 

AUDIT_Trigger