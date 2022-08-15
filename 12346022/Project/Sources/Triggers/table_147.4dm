
If (isTriggerEnabled)
	If (Trigger event:C369=On Saving New Record Event:K3:1)
		setAddressIdAndHash
		setDateTimeUser(->[Addresses:147]creationDate:19; ->[Addresses:147]creationTime:22)
	End if 
	
	If (Trigger event:C369=On Saving Existing Record Event:K3:2)
		setAddressIdAndHash
	End if 
End if 

TriggerSync