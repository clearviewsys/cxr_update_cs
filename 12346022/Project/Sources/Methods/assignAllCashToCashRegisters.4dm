//%attributes = {}
// this method create m*n record in cashaccounts

// when n is the nubmer of accounts that are cash

// and m is the number of cash registers

// it basically assign all cash accounts to all cash registers. 

C_LONGINT:C283($i; $j)

READ ONLY:C145([Currencies:6])
ALL RECORDS:C47([Currencies:6])
C_TEXT:C284($cashAccountID)
READ ONLY:C145([CashRegisters:33])
ALL RECORDS:C47([CashRegisters:33])
FIRST RECORD:C50([CashRegisters:33])
READ ONLY:C145([Accounts:9])

For ($j; 1; Records in selection:C76([CashRegisters:33]))
	FIRST RECORD:C50([Currencies:6])
	For ($i; 1; Records in selection:C76([Currencies:6]))
		
		If ([Currencies:6]hasCashAccount:23=True:C214)
			$cashAccountID:=makeCashAccountID([Currencies:6]CurrencyCode:1; [CashRegisters:33]CashRegisterID:1)
			assignCashAccountToCashRegister($cashAccountID; [CashRegisters:33]CashRegisterID:1)
		End if 
		
		// unload record([currencies])` this may be a good idea to add (the unload record), haven't tested yet
		
		NEXT RECORD:C51([Currencies:6])
	End for 
	NEXT RECORD:C51([CashRegisters:33])
End for 
READ ONLY:C145([CashAccounts:34])
ALL RECORDS:C47([CashAccounts:34])
orderByCashAccounts