HandleEntryFormMethod
If (Form event code:C388=On Load:K2:1)
	UNLOAD RECORD:C212([Accounts:9])
End if 

If (onModifyRecordEvent)
	//starttransaction // disabled by: Barclay Berry (2/24/13) per Tiran
	READ WRITE:C146([CashInventory:35])
	RELATE MANY:C262([CashAccounts:34]AccountID:1)
	orderBycashInventory
End if 

calcCashInventorySums
//HandleEntryForm 