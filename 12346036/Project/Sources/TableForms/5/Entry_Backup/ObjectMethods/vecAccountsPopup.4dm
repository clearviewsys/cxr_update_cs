C_TEXT:C284(INV_vNextAccountID)
inv_vNextAccountID:=""
If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	If (Self:C308->>1)
		QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=Self:C308->{Self:C308->})  // find the subledger account
		ASSERT:C1129(Records in selection:C76([Accounts:9])>0; "script: vecAccounts in Invoice")
		If ([Accounts:9]CurrencyAlias:26="")
			setVecCurrency([Accounts:9]Currency:6; True:C214)  // set the currency to the account currency
			
		Else 
			setVecCurrency([Accounts:9]CurrencyAlias:26; True:C214)  // set the currency to the account currency
		End if 
		
		INV_vNextAccountID:=[Accounts:9]AccountID:1
	Else 
		INV_vNextAccountID:=""  // added on march 12, 2009 (TB)
	End if 
	//GOTO OBJECT(*;"vAmount")
End if 