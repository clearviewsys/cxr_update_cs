C_LONGINT:C283($0)

$0:=0  //Assume the database request will be granted
If (isTriggerEnabled)
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			
			//: (Trigger event=_o_On Loading Record Event)
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
	End case 
	writeLogTrigger([Accounts:9]AccountID:1; $0)
End if 

AUDIT_Trigger
TriggerSync
