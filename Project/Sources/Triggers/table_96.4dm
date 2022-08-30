TriggerSync

C_LONGINT:C283($0)

$0:=0
If (isTriggerEnabled)
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			[OrderLines:96]orderLineID:1:="-"+makeorderLineID
			[OrderLines:96]orderValue:14:=[OrderLines:96]QtyOrdered:5*[OrderLines:96]denomination:4
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			[OrderLines:96]orderValue:14:=[OrderLines:96]QtyOrdered:5*[OrderLines:96]denomination:4
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	
End if 

AUDIT_Trigger