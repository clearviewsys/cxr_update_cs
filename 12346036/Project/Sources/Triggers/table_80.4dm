C_LONGINT:C283($0)
$0:=0

If (isTriggerEnabled)
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			If ([CalendarEvents:80]UID:1="")
				[CalendarEvents:80]UID:1:=makeCalendarEventID
			End if 
			
			[CalendarEvents:80]CreatedByUser:20:=getApplicationUser
			[CalendarEvents:80]CreationDate:21:=Current date:C33
			[CalendarEvents:80]CreationTime:22:=Current time:C178
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			
			
			
			//: (Trigger event=_o_On Loading Record Event)
		: (Trigger event:C369=On Deleting Record Event:K3:3)
	End case 
	
	//writeLogTrigger ([CashInOuts]TransactionID;$0)
End if 

AUDIT_Trigger
TriggerSync