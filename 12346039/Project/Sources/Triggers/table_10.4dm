C_LONGINT:C283($0; $iError)

$iError:=0
//TRACE

If (isTriggerEnabled)
	
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			
			If (Sync_IsSyncProcess)  //don't update anything coming from sync take as is
			Else 
				If ([Registers:10]RegisterID:1="")
					[Registers:10]RegisterID:1:=makeRegisterID
				End if 
				
				setDateTimeUser(->[Registers:10]CreationDate:14; ->[Registers:10]CreationTime:15)
				RegistersTriggerHelper
			End if 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			//TRACE
			If (Old:C35([Registers:10]isValidated:35))  //8/23/17 added by IBB so validated is not changed
				revertRecord(->[Registers:10])  //added by TB
			Else 
				If (Sync_IsSyncProcess)  //don't update anything coming from sync take as is
				Else 
					setDateTimeUser(->[Registers:10]ModificationDate:20; ->[Registers:10]ModificationTime:21)
					RegistersTriggerHelper
					createRegisterAuditTrail(On Saving Existing Record Event:K3:2)
				End if 
				
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
			Case of 
				: (Current user:C182="designer")  //8/25/22 need a backdoor option @ibb
					createRegisterAuditTrail(On Deleting Record Event:K3:3)
				: ([Registers:10]isValidated:35)  //added by TB; we don't want reconciled records to be deleted
					$iError:=-22222  // 4D recommends errors between -15000 to -32000 only
				Else 
					createRegisterAuditTrail(On Deleting Record Event:K3:3)
			End case 
			
	End case 
	
	writeLogTrigger([Registers:10]RegisterID:1; $0)
	
End if 

//TriggerRegisters_OLD
TriggerSync  // previously sync_trigger 

AUDIT_Trigger


$0:=$iError