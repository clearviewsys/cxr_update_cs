C_LONGINT:C283($0)

$0:=0


Case of 
	: (Trigger event:C369=On Saving New Record Event:K3:1)
		If ([WebAttachments:86]CreateDate:4=!00-00-00!)
			[WebAttachments:86]CreateDate:4:=Current date:C33
		End if 
		
		If ([WebAttachments:86]CreateTime:7=?00:00:00?)
			[WebAttachments:86]CreateTime:7:=Current time:C178
		End if 
		
		[WebAttachments:86]CreateUser:6:=getApplicationUser
		
		
	: (Trigger event:C369=On Saving Existing Record Event:K3:2)
		
		
	: (Trigger event:C369=On Deleting Record Event:K3:3)
		
		
End case 