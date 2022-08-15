//%attributes = {}
Case of 
	: (Form event code:C388=On Load:K2:1)
		ALL RECORDS:C47([Currencies:6])
		SELECTION TO ARRAY:C260([Currencies:6]CurrencyCode:1; vCurrencyPopUp)
		If (Record number:C243([Registers:10])<0)  // new record - in this case use Base Currency as default

			vCurrencyPopUp{0}:=<>BaseCurrency
		Else   //modify record - in this case load the related bank account currency as default

			RELATE ONE:C42([Registers:10]AccountID:6)
			vCurrencyPopUp{0}:=[Accounts:9]Currency:6
		End if 
	: ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
		// after the combo box has been selected, assign the field to the new value    

		vCurrencyPopUp{0}:=vCurrencyPopUp{vCurrencyPopUp}
End case 

QUERY:C277([Accounts:9]; [Accounts:9]Currency:6=vCurrencyPopUp{0})
ORDER BY:C49([Accounts:9]; [Accounts:9]AccountID:1)
SELECTION TO ARRAY:C260([Accounts:9]AccountID:1; vOurBankAccountID)