//%attributes = {}
C_TEXT:C284(vCurrency; $currency)

If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(arrBankAccounts; 0)
	Case of 
		: (vCurrency#"")
			$currency:=vCurrency
		: (vCurrency="")
			$currency:=[Cheques:1]Currency:9
	End case 
	
	selectBankAccountsOfCurrency($currency; 1)
	SELECTION TO ARRAY:C260([Accounts:9]AccountID:1; arrBankAccounts)
End if 

bindPullDownToStringField(->arrBankAccounts; ->[Cheques:1]AccountID:7)

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	//selectBankAccountsOfCurrency ($currency)
	//SELECTION TO ARRAY([Accounts]AccountID;arrBankAccounts)
	
	RELATE ONE:C42([Cheques:1]AccountID:7)
	If ([Accounts:9]isBankAccount:7)
		setChequeStatus(1; [Cheques:1]AccountID:7)  // clear the cheque
	Else 
		setChequeStatus(0; [Cheques:1]AccountID:7)  // pending
	End if 
End if 