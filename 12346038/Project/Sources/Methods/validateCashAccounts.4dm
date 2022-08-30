//%attributes = {}
checkUniqueKey(->[CashAccounts:34]; ->[CashAccounts:34]AccountID:1; "Cash Account ID")
checkifRecordExists(->[CashRegisters:33]; ->[CashRegisters:33]CashRegisterID:1; ->[CashAccounts:34]CashRegisterID:2; "Cash Register ID")
checkifRecordExists(->[Accounts:9]; ->[Accounts:9]AccountID:1; ->[CashAccounts:34]AccountID:1; "Cash Account ID")

