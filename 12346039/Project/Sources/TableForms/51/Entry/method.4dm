HandleEntryFormMethod

Case of 
	: (onNewRecordEvent)
		If (getNextCustomer#"")
			[CallLogs:51]CustomerID:2:=getNextCustomer
			initNextCustomer
			RELATE ONE:C42([CallLogs:51]CustomerID:2)
			//SET ENTERABLE([CallLogs]CustomerID;False)
			setDateTimeUser(->[CallLogs:51]CallDate:3; ->[CallLogs:51]CallTime:4; ->[CallLogs:51]userID:5)
			GOTO OBJECT:C206([CallLogs:51]Notes:6)
		End if 
		If ([CallLogs:51]CustomerID:2=getWalkInCustomerID)
			GOTO OBJECT:C206([CallLogs:51]CustomerID:2)
		End if 
End case 