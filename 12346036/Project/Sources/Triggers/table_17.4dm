C_LONGINT:C283($0)

$0:=0
If (isTriggerEnabled)
	
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			
			createLinkID
			[Links:17]email:5:=strRemoveSpaces([Links:17]email:5)
			
			If ([Links:17]sameAsLinkID:52="")
				[Links:17]sameAsLinkID:52:=[Links:17]LinkID:1
			End if 
			
			If ([Links:17]isCompany:43)
				[Links:17]FullName:4:=[Links:17]CompanyName:42
			Else 
				[Links:17]FullName:4:=makeFullName([Links:17]FirstName:2; [Links:17]LastName:3)
			End if 
			setDateTimeUser(->[Links:17]CreationDate:20; ->[Links:17]CreationTime:21; ->[Links:17]createdByUser:39)
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			setDateTimeUserForced(->[Links:17]ModificationDate:22; ->[Links:17]ModificationTime:23; ->[Links:17]modifiedByUser:40)
			
			If ([Links:17]isCompany:43)
				[Links:17]FullName:4:=[Links:17]CompanyName:42
			Else 
				[Links:17]FullName:4:=makeFullName([Links:17]FirstName:2; [Links:17]LastName:3)
			End if 
			
			[Links:17]email:5:=strRemoveSpaces([Links:17]email:5)
			
			//: (Trigger event=_o_On Loading Record Event)
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	
	writeLogTrigger([Links:17]LinkID:1; $0)
End if 

AUDIT_Trigger
TriggerSync