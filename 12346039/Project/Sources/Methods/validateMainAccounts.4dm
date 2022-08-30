//%attributes = {}
checkUniqueKey(->[MainAccounts:28]; ->[MainAccounts:28]MainAccountID:1; "Main Account Short-Name (ID)")
//checkIfNullString (->[MainAccounts]_;"Main Account Name")
checkIfNullString(->[MainAccounts:28]AccountType:4; "Account Type")
