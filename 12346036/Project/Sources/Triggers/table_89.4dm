C_LONGINT:C283($0)

$0:=0

If (isTriggerEnabled)
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			If ([CSMRelations:89]CSMRelationID:1="")
				[CSMRelations:89]CSMRelationID:1:=makeCSMRelationID
			End if 
			
			[CSMRelations:89]creationDate:16:=Current date:C33
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			[CSMRelations:89]modificationDate:18:=Current date:C33
			
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	writeLogTrigger([CSMRelations:89]CSMRelationID:1; $0)
End if 

AUDIT_Trigger
TriggerSync

