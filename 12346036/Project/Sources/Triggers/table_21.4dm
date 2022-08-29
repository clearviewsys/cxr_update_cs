// be carefual about writing triggers in here
//
// DO NOT EVER PUT writeLogTrigger in this table
// it will cause infinite loop

// maybe you want to disable deleting from this table
// to make sure everything is always logged
C_LONGINT:C283($0)

$0:=0  //Assume the database request will be granted
If (isTriggerEnabled)
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			
			//: (Trigger event=_o_On Loading Record Event)
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
	End case 
End if 

AUDIT_Trigger