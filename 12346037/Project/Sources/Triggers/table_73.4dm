C_LONGINT:C283($0)

$0:=0

If (isTriggerEnabled)
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			If ([Reports:73]ID:1="")
				[Reports:73]ID:1:=makeReportsID
			End if 
			
			setDateTimeUser(->[Reports:73]CreationDate:4; ->[Reports:73]CreationTime:5)
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			
			//: (Trigger event=_o_On Loading Record Event)
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	writeLogTrigger([Reports:73]ID:1; $0)
End if 

AUDIT_Trigger
TriggerSync