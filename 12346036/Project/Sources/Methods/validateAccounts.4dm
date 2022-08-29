//%attributes = {}
//checkIfNullString (->vBranchShortName{vBranchShortName};"Branch Short Name")

checkIfNullString(->[Accounts:9]AccountID:1; "Account ID")
checkUniqueKey(->[Accounts:9]; ->[Accounts:9]AccountID:1; "Account ID")

checkIfNullString(->[Accounts:9]MainAccountID:2; "Main Account ID")
checkifRecordExists(->[MainAccounts:28]; ->[MainAccounts:28]MainAccountID:1; ->[Accounts:9]MainAccountID:2; "Main Account ID")

checkIfNullString(->[Accounts:9]Currency:6; "Account Currency")
//checkIfValidDate (->[Accounts]OpeningBalanceDate;"Opening Date")
//checkLowerBound (->[Accounts]OpeningDebit;"Opening Balance";0)

If ([Accounts:9]isForeignAccount:15)
	checkIfNullString(->[Accounts:9]AgentID:16; "Foreign Accounts must have an authorized channel assigned.")
End if 

If ([Accounts:9]isCashAccount:3 & Not:C34([Accounts:9]isDebit:11))
	checkAddWarning("A Cash account is a debit account.")
End if 

If ([Accounts:9]isBankAccount:7 & Not:C34([Accounts:9]isDebit:11))
	checkAddWarning("A Bank account is usually a debit account.")
End if 

If ([Accounts:9]isDebit:11)  // debit account should always have a debit balance
	If ([Accounts:9]OpeningCredit:8>[Accounts:9]OpeningDebit:9)
		checkAddWarning("An account of type "+[Accounts:9]AccountType:5+" has usually a debit balance")
	End if 
Else 
	If ([Accounts:9]OpeningCredit:8<[Accounts:9]OpeningDebit:9)
		checkAddWarning("An account of type "+[Accounts:9]AccountType:5+" has usually a credit balance")
	End if 
End if 

If (([Accounts:9]isCashAccount:3) & ([Accounts:9]isBankAccount:7))
	//checkAddError ("Account Cannot be both a cash and bank account")d
	// Modified by: Tiran Behrouz (5/30/13)
	checkAddWarning("Are you sure account is both cash and bank account?")
End if 