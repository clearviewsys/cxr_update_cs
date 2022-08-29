//%attributes = {}
// selectCustomerwOustandingBalance (mainAccountID)
// ex : pass c_Payables  or c_Receivables or pending


READ ONLY:C145([Customers:3])
READ ONLY:C145([Registers:10])

If (Count parameters:C259=0)
	selectAccountsPending
Else 
	C_TEXT:C284($1; $mainAccountID)
	$mainAccountID:=$1
	// first find all accounts that are receivale or payable
	QUERY:C277([Accounts:9]; [Accounts:9]MainAccountID:2=$mainAccountID)
End if 

// project these accounts into their registers (select all registers that are pending)
RELATE MANY SELECTION:C340([Registers:10]AccountID:6)

CREATE SET:C116([Registers:10]; "pendingRegistersSet")

// now project these registers into their related customers
RELATE ONE SELECTION:C349([Registers:10]; [Customers:3])

FIRST RECORD:C50([Customers:3])

C_REAL:C285(vFromAmount; vToAmount; vFromBalance; vToBalance)
C_LONGINT:C283($i)
CREATE EMPTY SET:C140([Customers:3]; "customersPendingSet")

For ($i; 1; Records in selection:C76([Customers:3]))
	// reload all the registers that are related to pending transactions
	USE SET:C118("pendingRegistersSet")
	// filter those for this customer only
	QUERY SELECTION:C341([Registers:10]; [Registers:10]CustomerID:5=[Customers:3]CustomerID:1)
	C_REAL:C285(vSumDebitsLocal; vSumCreditsLocal; vBalanceLocal)
	getRegisterSums(->vSumDebitsLocal; ->vSumCreditsLocal; ->vBalanceLocal)
	
	If (vBalanceLocal#0)
		ADD TO SET:C119([Customers:3]; "customersPendingSet")
	End if 
	
	NEXT RECORD:C51([Customers:3])
End for 

USE SET:C118("customersPendingSet")
CLEAR SET:C117("customersPendingSet")
CLEAR SET:C117("pendingRegistersSet")
orderbyCustomers
FIRST RECORD:C50([Customers:3])
