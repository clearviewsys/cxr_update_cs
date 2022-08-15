
If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	RELATE ONE:C42([AccountInOuts:37]CustomerID:2)  // load the customer ID
End if 

If (onNewRecordEvent)
	preventAddRecordInEntryForm(Current form table:C627)
	
	// I commented out the following block 
	// I don't understand why we need to enter info
	//UNLOAD RECORD([Customers])
	//UNLOAD RECORD([Accounts])
	//[AccountInOuts]AccountInOutID:=makeAccountInOutID 
	//[AccountInOuts]Date:=Current date
	//[AccountInOuts]InvoiceID:="N/A"
End if 
HandleEntryFormMethod



