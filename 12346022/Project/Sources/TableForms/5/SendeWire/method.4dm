C_PICTURE:C286(vAttachedPicture)
C_TEXT:C284(vSenderMessage)

Case of 
	: (Form event code:C388=On Load:K2:1)
		READ ONLY:C145([Links:17])
		QUERY:C277([Links:17]; [Links:17]CustomerID:14=[Invoices:5]CustomerID:2)
		If (Records in selection:C76([Links:17])>0)
			SELECTION TO ARRAY:C260([Links:17]LinkID:1; arrLinks)
			arrLinks:=0
		End if 
		UNLOAD RECORD:C212([Links:17])
		
		fillArrayWithAccounts(->arrOurBankAccount; [Invoices:5]toCurrency:8; True:C214)
		arrOurBankAccount:=0
		unloadRecordBanks
		vSenderMessage:=""
		CLEAR VARIABLE:C89(vAttachedPicture)
End case 