//%attributes = {}
// assignCashAccountToCashRegister( cashAccountID ; cashRegisterID)


C_TEXT:C284($1; $2)
READ ONLY:C145([CashAccounts:34])
QUERY:C277([CashAccounts:34]; [CashAccounts:34]AccountID:1=$1; *)
QUERY:C277([CashAccounts:34];  & ; [CashAccounts:34]CashRegisterID:2=$2)

If (Records in selection:C76([CashAccounts:34])=0)  // record pair doesn't exist

	READ WRITE:C146([CashAccounts:34])
	CREATE RECORD:C68([CashAccounts:34])
	[CashAccounts:34]AccountID:1:=$1
	[CashAccounts:34]CashRegisterID:2:=$2
	SAVE RECORD:C53([CashAccounts:34])
	UNLOAD RECORD:C212([CashAccounts:34])
End if 
READ ONLY:C145([CashAccounts:34])
