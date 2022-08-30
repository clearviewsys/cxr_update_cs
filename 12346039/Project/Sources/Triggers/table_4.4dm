C_LONGINT:C283($0)

If (isTriggerEnabled)
	
	$0:=0
	If (isTriggerEnabled)
		Case of 
				
			: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
				If ([LinkedDocs:4]LinkedDocID:12="")
					[LinkedDocs:4]LinkedDocID:12:=makeLinkedDocID
				End if 
				
				[LinkedDocs:4]createdByUser:14:=getApplicationUser
				[LinkedDocs:4]creationDate:15:=Current date:C33
				
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
				If ([LinkedDocs:4]LinkedDocID:12="")
					[LinkedDocs:4]LinkedDocID:12:=makeLinkedDocID
				End if 
				
				[LinkedDocs:4]modificationDate:17:=Current date:C33
				[LinkedDocs:4]modifiedByUser:16:=getApplicationUser
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
		End case 
		
	End if 
End if 

AUDIT_Trigger
TriggerSync