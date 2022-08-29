//%attributes = {}
// selectAccountsRelatedToTill (CashRegisterID)

C_TEXT:C284($till; $1)

$till:=$1
READ ONLY:C145([CashRegisters:33])
READ ONLY:C145([Accounts:9])
READ ONLY:C145([CashAccounts:34])

QUERY:C277([CashRegisters:33]; [CashRegisters:33]CashRegisterID:1=$till)
RELATE MANY SELECTION:C340([CashAccounts:34]CashRegisterID:2)  // select all the cash accounts related to the tills selected
RELATE ONE SELECTION:C349([CashAccounts:34]; [Accounts:9])  // select all related accounts
