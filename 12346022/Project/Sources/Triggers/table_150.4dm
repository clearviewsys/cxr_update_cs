C_LONGINT:C283($0)

$0:=0
If (isTriggerEnabled)
	
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			If ([AML_AggrRules:150]ruleID:53="")
				[AML_AggrRules:150]ruleID:53:=makeAMLRuleID
			End if 
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	
	//writeLogTrigger ([Denominations];$0) // activate this line for logging changes
End if 
TriggerSync