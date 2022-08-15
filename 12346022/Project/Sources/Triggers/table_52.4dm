C_LONGINT:C283($0)
If (isTriggerEnabled)
	
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			C_TIME:C306($time)
			If ([Letters:52]LetterID:1="")
				[Letters:52]LetterID:1:=makeLetterID
			End if 
			
			setDateTimeUser(->[Letters:52]LetterDate:2; ->$time; ->[Letters:52]author:5)
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			//deleteRelatedManyRegister ([Wires]RegisterID)
	End case 
	writeLogTrigger([Letters:52]LetterID:1; $0)
End if 

AUDIT_Trigger