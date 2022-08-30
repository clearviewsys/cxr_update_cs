//%attributes = {}

checkUniqueKey(->[CashRegisters:33]; ->[CashRegisters:33]CashRegisterID:1; "Till ID")
checkIfNullString(->[CashRegisters:33]CashRegisterName:7; "Cash Register Name")
checkAddErrorIf(([CashRegisters:33]isAdminOnly:10 & [CashRegisters:33]isShared:8); "A shared till cannot be for Admins only!")
