//%attributes = {}
// 
C_LONGINT:C283($0)

$0:=0
If (isTriggerEnabled)
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
End if 

// TriggerSync - Only if table is synchronizable 
//AUDIT_Trigger