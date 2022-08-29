//%attributes = {}
C_LONGINT:C283($i; $n; $m)

READ ONLY:C145([Accounts:9])

If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(arrAccountIDs; 0)
	ARRAY REAL:C219(arrOpenings; 0)
	ARRAY REAL:C219(arrTransferIns; 0)
	ARRAY REAL:C219(arrTransferOuts; 0)
	ARRAY REAL:C219(arrBought; 0)
	ARRAY REAL:C219(arrSold; 0)
	ARRAY REAL:C219(arrBalances; 0)
	ARRAY TEXT:C222(arrCurrencies; 0)
	ARRAY REAL:C219(arrDebits; 0)
	ARRAY REAL:C219(arrCredits; 0)
	ARRAY REAL:C219(arrAvgBuyRates; 0)
	ARRAY REAL:C219(arrAvgSellRates; 0)
	ARRAY REAL:C219(arrMarketValues; 0)
	ARRAY TEXT:C222(arrRemarks; 0)
End if 

listbox_deleteAllRows(->acc_PositionsListBox)

// first select the cash accounts
QUERY:C277([Accounts:9]; [Accounts:9]isCashAccount:3=True:C214)  // first select all cash accounts
RELATE MANY SELECTION:C340([Registers:10]AccountID:6)  // then select all registers that are cash trades
filterRegistersInDateRange(vFromDate; vToDate; numToBoolean(cbApplyDateRange))
RELATE ONE SELECTION:C349([Registers:10]; [Currencies:6])  // then select all the currencies that have a cash trade

//SELECTION TO ARRAY([Currencies]ISO4217;arrCurrs)
DISTINCT VALUES:C339([Currencies:6]ISO4217:31; arrCurrs)
SORT ARRAY:C229(arrCurrs)
$n:=Size of array:C274(arrCurrs)  // n is the number of currencies that have been dealt with cash

For ($i; 1; $n)
	listbox_appendRow(->acc_PositionsListBox)
	acc_fillCashPositionsListBoxRow($i; arrCurrs{$i})
End for 

// then select the bank accounts
QUERY:C277([Accounts:9]; [Accounts:9]isBankAccount:7=True:C214)  // first select all bank accounts
RELATE MANY SELECTION:C340([Registers:10]AccountID:6)  // then select all registers that are cash trades
filterRegistersInDateRange(vFromDate; vToDate; numToBoolean(cbApplyDateRange))
RELATE ONE SELECTION:C349([Registers:10]; [Currencies:6])  // then select all the currencies that have a bank account

//SELECTION TO ARRAY([Currencies]ISO4217;arrCurrs)
DISTINCT VALUES:C339([Currencies:6]ISO4217:31; arrCurrs)
$m:=Size of array:C274(arrCurrs)
SORT ARRAY:C229(arrCurrs)

For ($i; 1; $m)
	listbox_appendRow(->acc_PositionsListBox)
	acc_fillBankPositionsListBoxRow($i+$n; arrCurrs{$i})
End for 


ARRAY TEXT:C222(arrCurrs; 0)