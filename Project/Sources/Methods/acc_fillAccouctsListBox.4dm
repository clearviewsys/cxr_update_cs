//%attributes = {}
// acc_fillAccountsListBox
// This method is called in the outside call method of the Accounts.Listbox form method

C_LONGINT:C283($i; $n)
C_REAL:C285(vSumMarketValues)

READ ONLY:C145([Accounts:9])
READ ONLY:C145([MainAccounts:28])
READ ONLY:C145([Currencies:6])

If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(acc_arrAccountIDs; 0)
	ARRAY TEXT:C222(acc_arrAccountTypes; 0)
	ARRAY TEXT:C222(acc_arrCurrencies; 0)
	ARRAY TEXT:C222(acc_arrMainAccounts; 0)
	ARRAY REAL:C219(acc_arrTransfers; 0)
	ARRAY REAL:C219(acc_arrOpenings; 0)
	ARRAY REAL:C219(acc_arrIns; 0)
	ARRAY REAL:C219(acc_arrOuts; 0)
	ARRAY REAL:C219(acc_arrBalances; 0)
	ARRAY REAL:C219(acc_arrDebits; 0)
	ARRAY REAL:C219(acc_arrCredits; 0)
	ARRAY REAL:C219(acc_arrFees; 0)
	ARRAY REAL:C219(acc_arrUnrealizedGains; 0)
	
	ARRAY REAL:C219(acc_arrMarketRates; 0)
	ARRAY REAL:C219(acc_arrMarketRatesInv; 0)
	
	ARRAY REAL:C219(acc_arrMarketValues; 0)
	
	ARRAY TEXT:C222(acc_arrIsFlagged; 0)  // switched from type picture to type text for speed optimization 
	ARRAY BOOLEAN:C223(acc_arrIsForManagers; 0)
	ARRAY REAL:C219(acc_arrReorderIn; 0)
	
End if 

C_LONGINT:C283($progress)

$progress:=launchProgressBar("Accounts")

$n:=Records in selection:C76([Accounts:9])
$i:=1
//SELECTION TO ARRAY([Accounts]

If ($n<=20)
	HIDE PROCESS:C324($progress)
End if 
FIRST RECORD:C50([Accounts:9])
//ORDER BY([Accounts];[Accounts]MainAccountID;>;[Accounts]AccountID)
listbox_deleteAllRows(->acc_AccountsListBox)  // do not delete; or else everytime you press all records, the lines will keep adding up

ARRAY BOOLEAN:C223(acc_accountsListBox; 0)
C_BOOLEAN:C305($isManager)
$isManager:=isUserManager  // to reduce the query to the database everytime we check this balance

Repeat 
	listbox_appendRow(->acc_AccountsListBox)
	acc_fillAccountsListBoxRow($i; $isManager)
	NEXT RECORD:C51([Accounts:9])
	If ($i%40=1)
		refreshProgressBar($progress; $i; $n)
	End if 
	$i:=$i+1
Until (($i>$n) | (isProgressBarStopped($progress)))
refreshRowCount(->acc_accountsListBox)
HIDE PROCESS:C324($progress)
