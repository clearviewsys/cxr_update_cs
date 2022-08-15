C_LONGINT:C283($0)


If (isTriggerEnabled)
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			If ([CallLogs:51]CallLogID:1="")
				[CallLogs:51]CallLogID:1:=makeCallLogID  // for first time
			End if 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			
	End case 
End if 

TriggerSync

//$0:=0