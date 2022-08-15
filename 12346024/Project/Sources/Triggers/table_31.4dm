C_LONGINT:C283($0)

$0:=0
If (isTriggerEnabled)
	
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			If ([Denominations:31]DenominationID:1="")
				[Denominations:31]DenominationID:1:=makeDenominationsID  // for first time
			End if 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			[Denominations:31]DenominationID:1:=makeDenominationsID  // for first time
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	
	//writeLogTrigger ([Denominations];$0)
End if 

AUDIT_Trigger
TriggerSync
