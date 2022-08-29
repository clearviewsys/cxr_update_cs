HandleEntryFormMethod

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	If (Not:C34(Is new record:C668([MainAccounts:28])))  // only if its not a new record, i.e: modified or loaded
		
		RELATE MANY:C262([MainAccounts:28]MainAccountID:1)
		SELECTION TO ARRAY:C260([Accounts:9]AccountID:1; acc_arrAccountIDs; [Accounts:9]Currency:6; acc_arrCurrencies)
		listbox_selectLastRow(->acc_subledgerListBox)
	Else 
		listbox_deleteAllRows(->acc_subledgerListBox)
	End if 
End if 

