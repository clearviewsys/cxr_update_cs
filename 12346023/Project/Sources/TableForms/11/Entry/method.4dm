HandleEntryFormMethod
setApplicationUserForTable(->[MESSAGES:11]; ->[MESSAGES:11]createdByUserID:15; ->[MESSAGES:11]ModifiedByUserID:16)


If (onNewRecordEvent)  // on new record
	[MESSAGES:11]FromUserID:5:=getApplicationUser  // changed in version 3.425 from current user
	[MESSAGES:11]Date:3:=Current date:C33
	[MESSAGES:11]Time:4:=Current time:C178
	[MESSAGES:11]MessageID:1:=makeMessageID
	[MESSAGES:11]isMessageSent:14:=True:C214
	UNLOAD RECORD:C212([Customers:3])
	UNLOAD RECORD:C212([Agents:22])
End if   // be aware of putting any else here because of the on load event in the condition

If (onModifyRecordEvent)  // on modify record 
	If (Not:C34([MESSAGES:11]isMessageSent:14))
		[MESSAGES:11]isRead:12:=True:C214
	End if 
End if 

If (Form event code:C388=On Load:K2:1)
	If ([MESSAGES:11]isMessageSent:14)
		OBJECT SET ENTERABLE:C238([MESSAGES:11]ReplyBody:9; False:C215)  // cant reply to our own message
		OBJECT SET ENTERABLE:C238([MESSAGES:11]isActionTaken:11; False:C215)
	Else 
		OBJECT SET ENTERABLE:C238([MESSAGES:11]ReplyBody:9; True:C214)
		OBJECT SET ENTERABLE:C238([MESSAGES:11]isActionTaken:11; True:C214)
	End if 
End if 
