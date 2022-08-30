HandleEntryFormMethod
Case of 
	: (onNewRecordEvent)
		If (getNextCustomer#"")
			[Mailboxes:56]MailboxID:1:=makeMailboxID
			[Mailboxes:56]CustomerID:2:=getNextCustomer
			initNextCustomer
			RELATE ONE:C42([Mailboxes:56]CustomerID:2)
			OBJECT SET ENTERABLE:C238([Mailboxes:56]CustomerID:2; False:C215)
		End if 
End case 