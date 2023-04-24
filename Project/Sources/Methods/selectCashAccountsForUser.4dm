//%attributes = {}
// selectCashAccountsForUser({Currency})
// selects all CashAccounts records that the application user is allowed to access
// ie: all Accounts that the user has signed in with their cash registers machine or shared by all

C_TEXT:C284($1)
READ ONLY:C145([CashRegisters:33])
READ ONLY:C145([CashAccounts:34])
READ ONLY:C145([Accounts:9])

QUERY:C277([CashRegisters:33]; [CashRegisters:33]UserID:2=getApplicationUser)
If (Records in selection:C76([CashRegisters:33])=0)  // no such user found, then look for a shared cash account
	QUERY:C277([CashRegisters:33]; [CashRegisters:33]isShared:8=True:C214)  // find the cash registers that are shared
End if 

RELATE MANY SELECTION:C340([CashAccounts:34]CashRegisterID:2)  // select cash accounts related to that user
RELATE ONE SELECTION:C349([CashAccounts:34]; [Accounts:9])  // map all cash accounts selected in their accounts

If (Count parameters:C259=1)  // filter only the given currency accounts
	//QUERY SELECTION([CashAccounts];[CashAccounts]
	QUERY SELECTION:C341([Accounts:9]; [Accounts:9]Currency:6=$1)
End if 