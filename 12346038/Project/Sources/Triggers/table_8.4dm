C_LONGINT:C283($0)
If (isTriggerEnabled)
	
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			If (Old:C35([Wires:8]isReleased:64)=True:C214)  // added by TB
				revertRecord(->[Wires:8])  // we don't want a paid wire to become unpaid
			End if 
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			//deleteRelatedManyRegister ([Wires]RegisterID)
	End case 
	writeLogTrigger([Wires:8]CXR_WireID:1; $0)
End if 

AUDIT_Trigger
TriggerSync