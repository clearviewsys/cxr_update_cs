checkInit
validateAccounts

//C_POINTER($1) ` Jan 16, 2012 17:55:31 -- I.Barclay Berry 

If (isValidationConfirmed)
	If ([Accounts:9]isForeignAccount:15)  // then create an ewire_payable account
		PUSH RECORD:C176([Accounts:9])
		createeWireAccounts([Accounts:9]Currency:6)
		POP RECORD:C177([Accounts:9])
		
		//PUSH RECORD([Accounts])
		//createeWireAccounts ([Accounts]Currency;False)
		//POP RECORD([Accounts])
		
		SAVE RECORD:C53([Accounts:9])
		//VALIDATE TRANSACTION // disabled by: Barclay Berry (2/24/13) per Tiran
		//ALERT ("The account "+makeeWirePayable ([Accounts]Currency)+" has been created.")
	End if 
Else 
	REJECT:C38
End if 
