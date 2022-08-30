TriggerSync

C_LONGINT:C283($0)

$0:=0  //Assume the database request will be granted
If (isTriggerEnabled)
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			If ([AML_Reports:119]AML_ReportID:14="")
				[AML_Reports:119]AML_ReportID:14:=makeAML_ReportID
			End if 
			[AML_Reports:119]creationDate:23:=Current date:C33
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
	End case 
	
End if 
