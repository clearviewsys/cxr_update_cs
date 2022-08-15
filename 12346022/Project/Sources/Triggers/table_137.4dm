TriggerSync

C_LONGINT:C283($0)

$0:=0  //Assume the database request will be granted
If (isTriggerEnabled)
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			If ([AML_Alerts:137]alertID:2="")
				[AML_Alerts:137]alertID:2:=makeAML_AlertID
				[AML_Alerts:137]date:5:=Current date:C33
			End if 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
	End case 
End if 

