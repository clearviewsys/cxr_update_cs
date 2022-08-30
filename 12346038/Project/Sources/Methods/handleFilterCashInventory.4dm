//%attributes = {}
// handleFilterCashInventory
// this methods is called from a 'Filter' button in Cash Registers View

C_LONGINT:C283(vShowAllDenominations)


// do not change order ***************
RELATE MANY SELECTION:C340([CashInventory:35]CashAccountID:2)  // load all the related cash invetories (do not change order)
If (vShowAllDenominations=0)
	QUERY SELECTION:C341([CashInventory:35]; [CashInventory:35]SystemCount:6#0)  // filter only non-zeroes
	RELATE ONE SELECTION:C349([CashInventory:35]; [CashAccounts:34])  // now filter only those cash accounts that have a related inventory (ie: non-zero)
End if 
//******************************

orderByCashAccounts
orderBycashInventory