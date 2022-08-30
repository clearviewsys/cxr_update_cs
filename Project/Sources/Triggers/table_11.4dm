If (isTriggerEnabled)
	
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			If ([MESSAGES:11]MessageID:1="")
				[MESSAGES:11]MessageID:1:=makeMessageID
			End if 
			setDateTimeUser(->[MESSAGES:11]Date:3; ->[MESSAGES:11]Time:4)
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	writeLogTrigger([MESSAGES:11]MessageID:1; $0)
End if 

AUDIT_Trigger