
C_LONGINT:C283($0)

$0:=0
If (isTriggerEnabled)
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			If ([Relations:154]relationID:7="")
				[Relations:154]relationID:7:=makeRelationID
			End if 
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			If ([Relations:154]relationID:7="")
				[Relations:154]relationID:7:=makeRelationID
			End if 
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	//writeLogTrigger ([Denominations];$0) // activate this line for logging changes
End if 
TriggerSync
