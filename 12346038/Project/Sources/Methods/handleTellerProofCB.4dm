//%attributes = {}
// handleTellerProofCB
// this method handle the combo box in the tellerproof form

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		C_LONGINT:C283(cbValidate)
		C_TEXT:C284(vCurrency; vCashAccount)
		
		cbValidate:=0
		initTellerProofVars
		
		selectCashAccountsForUser
		vCashAccount:=[Accounts:9]AccountID:1
		
		//_O_ARRAY STRING(3;cbCurrencies;0)
		ARRAY TEXT:C222(cbCurrencies; 0)
		//QUERY SELECTION BY FORMULA([Accounts];getAccountBalance ([Accounts]AccountID)>0)  ` only filter accounts with positive balance
		RELATE ONE SELECTION:C349([Accounts:9]; [Currencies:6])  // map the accounts into their currencies
		SELECTION TO ARRAY:C260([Currencies:6]ISO4217:31; cbCurrencies)
		
		If (Size of array:C274(cbCurrencies)>0)  // if the list of currencies has at least one currency
			SORT ARRAY:C229(cbCurrencies)
			cbCurrencies:=1
			vCurrency:=cbCurrencies{1}
			cbCurrencies{0}:=vCurrency
			
			fillTellerProofArrays(vCurrency)
		Else 
			myAlert("There were no accessible cash accounts for reconciliation.")
			
		End if 
		
		
	: ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))  // on clicked or on data change 
		
		C_TEXT:C284(vCurrency; vCashAccount)
		vCashAccount:=""
		
		vCurrency:=cbCurrencies{cbCurrencies}  // first assign vCurrency to the selection from the pulldown
		pickCurrency(->vCurrency)  // pick the correct currency using the picker
		cbCurrencies{cbCurrencies}:=vCurrency  // then reassign the pulldown menu to the picked currency
		
		fillTellerProofArrays(vCurrency)
		
End case 



