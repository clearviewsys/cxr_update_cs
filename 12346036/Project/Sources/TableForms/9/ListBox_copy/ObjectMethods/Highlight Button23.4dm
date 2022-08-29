C_TEXT:C284($accountID)

If (Form event code:C388=On Clicked:K2:4)
	
	If (Shift down:C543)
		CONFIRM:C162("Are you sure you wish to replicate this account in all currencies?"; "Yes"; "No")
		If (OK=1)
			listbox_QueryRecordFromRows(->acc_accountsListBox; ->[Accounts:9]; ->[Accounts:9]AccountID:1; ->acc_arrAccountIDs)
			$accountID:=[Accounts:9]AccountID:1
			duplicateAccountPlus($accountID)
			myAlert("Account Replicated Successfully")
		End if 
		
	Else 
		listbox_QueryRecordFromRows(->acc_accountsListBox; ->[Accounts:9]; ->[Accounts:9]AccountID:1; ->acc_arrAccountIDs)
		duplicateAccounts
	End if 
	
End if 