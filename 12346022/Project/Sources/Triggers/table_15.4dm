
C_LONGINT:C283($0)
$0:=0  // Assume the database request will be granted
If (isTriggerEnabled)
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			//RELATE ONE([WebSessions]webUsername)
			//
			//[WebSessions]SessionID:=MakeACTIVE_USERSContextID ([WebUsers]isCustomer)
			//[WebSessions]LoginDate:=Current date
			//[WebSessions]LoginTime:=Current time
			//[WebSessions]LastActivityTime:=Current time
			//
			//READ WRITE([WebUsers])
			//[WebUsers]IncorrectPasswordCount:=[WebUsers]IncorrectPasswordCount+1
			//SAVE RECORD([WebUsers])
			//UNLOAD RECORD([WebUsers])
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			RecordUSERSLog([WebSessions:15]webUsername:2; [WebSessions:15]SessionID:1; [WebSessions:15]IPNumber:3; [WebSessions:15]LoginDate:4; [WebSessions:15]LoginTime:5; Current date:C33; Current time:C178)
			
	End case 
End if 

AUDIT_Trigger