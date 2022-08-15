
// 
C_LONGINT:C283($0)

$0:=0
If (isTriggerEnabled)
	
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			[ThirdParties:101]creationDate:34:=Current date:C33
			If ([ThirdParties:101]ThirdPartiesID:31="")
				[ThirdParties:101]ThirdPartiesID:31:=makeThirdPartiesID
			End if 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			
	End case 
	
End if 

AUDIT_Trigger
TriggerSync