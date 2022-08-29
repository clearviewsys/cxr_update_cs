// 
C_LONGINT:C283($0)

$0:=0
If (isTriggerEnabled)
	
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			If ([TellerProofLines:79]TellerProofLineID:9="")
				[TellerProofLines:79]TellerProofLineID:9:=makeTellerProofLineID
			End if 
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	
	//writeLogTrigger ([Denominations];$0) // activate this line for logging changes
End if 

AUDIT_Trigger
TriggerSync
