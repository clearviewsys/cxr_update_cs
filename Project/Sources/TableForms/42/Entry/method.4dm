HandleEntryForm
Case of 
	: (onNewRecordEvent)
		If (getNextCustomer#"")
			If (getNextCustomer=getWalkInCustomerID)
				[WireTemplates:42]CustomerID:2:=""
				UNLOAD RECORD:C212([Customers:3])
				[WireTemplates:42]WireTemplateID:1:=makeWireTemplateID
			Else 
				[WireTemplates:42]WireTemplateID:1:=makeWireTemplateID
				[WireTemplates:42]CustomerID:2:=getNextCustomer
				initNextCustomer
				RELATE ONE:C42([WireTemplates:42]CustomerID:2)
				//SET ENTERABLE([BankAccounts]CustomerID;False)
			End if 
		End if 
End case 