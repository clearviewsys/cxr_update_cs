C_LONGINT:C283($0)

$0:=0  //Assume the database request will be granted
If (isTriggerEnabled)
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			If ([ServerPrefs:27]ServerPrefID:84="")
				[ServerPrefs:27]ServerPrefID:84:=makeServerPrefID
			End if 
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			If ([ServerPrefs:27]ServerPrefID:84="")
				[ServerPrefs:27]ServerPrefID:84:=makeServerPrefID
			End if 
	End case 
	//writeLogTrigger ([Accounts]AccountID;$0)
End if 

triggerTemplate
AUDIT_Trigger