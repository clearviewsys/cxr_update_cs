// FORM METHOD
// [Accounts]
HandleEntryFormMethod
//HandleBankAccountEntry
C_TEXT:C284(vDescription; vSubAccount)


If (Form event code:C388=On Load:K2:1)
	GOTO OBJECT:C206([Accounts:9]AccountCode:4)
	vSubAccount:=""
	vDescription:=""
End if 


If (onNewRecordEvent)
	[Accounts:9]Currency:6:=<>baseCurrency
	hideObjectsOnTrue(True:C214; "b_rename")
End if 

If (onModifyRecordEvent)
	RELATE ONE:C42([Accounts:9]MainAccountID:2)
	
End if 


If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Outside Call:K2:11))
	setEnterableIff([Accounts:9]isForeignAccount:15; "AuthorizedUser")
	RELATE ONE:C42([Accounts:9]MainAccountID:2)
	If ([Accounts:9]CustomerID:20#"")
		RELATE ONE:C42([Accounts:9]CustomerID:20)
	Else 
		UNLOAD RECORD:C212([Customers:3])
	End if 
	arrAccountType:=[Accounts:9]Type:36  // update the dropdown
	
	
	//If (FORM Get current page=3)  // only if the third tab was visible
	QUERY:C277([SubAccounts:112]; [SubAccounts:112]AccountID:4=[Accounts:9]AccountID:1)
	orderBySubAccounts
	REDRAW:C174(mainListBox1)
	//End if 
	
	
End if 

If ([Accounts:9]AgentID:16#"")
	QUERY:C277([Agents:22]; [Agents:22]AgentID:1=[Accounts:9]AgentID:16)
Else 
	UNLOAD RECORD:C212([Agents:22])
End if 

RELATE ONE:C42([Accounts:9]Currency:6)
