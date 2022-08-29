//%attributes = {}
//author: Amir
//date: 7th Sept. 2018
//calculate account and sub account summary for given date range
//used for sub account summary screen report
//this method uses current selection of accounts to calculate summary values.

C_POINTER:C301(listBoxPtr)
C_LONGINT:C283($i; $j; $k; $numAccounts; $numSubAccounts)
C_LONGINT:C283($progress)
C_REAL:C285(vTransferIn; vTransferOut)
ARRAY TEXT:C222(arrAccounts; 0)
ARRAY TEXT:C222(arrSubAccounts; 0)
ARRAY REAL:C219(arrOpenings; 0)
ARRAY REAL:C219(arrTransfers; 0)
ARRAY REAL:C219(arrBuys; 0)
ARRAY REAL:C219(arrSells; 0)
ARRAY REAL:C219(arrBalances; 0)
ARRAY TEXT:C222(arrCurrencies; 0)
ARRAY REAL:C219(arrDebitLCs; 0)
ARRAY REAL:C219(arrCreditLCs; 0)
//variables used to show subtotal row for accounts with sub accounts
C_REAL:C285($sumOpenings; $sumTransfers; $sumBuys; $sumSells; $sumBalances; $sumDebitLCs; $sumCreditLCs)

READ ONLY:C145([Registers:10])
READ ONLY:C145([SubAccounts:112])
READ ONLY:C145([Accounts:9])

listBoxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "subaccountListBox")
listbox_deleteAllRows(listBoxPtr)
$numAccounts:=Records in selection:C76([Accounts:9])
If ($numAccounts>0)  //if there is any account to show the summary for
	$progress:=launchProgressBar("Sub Accounts Balance List")
	FIRST RECORD:C50([Accounts:9])
	$i:=1  //index for looping in Accounts
	$j:=1  //index for looping in SubAccounts
	$k:=1  //index for arrays of listbox
	Repeat 
		//first line: registers that have this account but no sub account
		$k:=listbox_appendRow(listBoxPtr)
		
		If (isUserAllowedToViewThisAccount)  // if account is for managers only but the user is not administrator then don't show the balances
			getAccountOnlyBalanceInDateRang([Accounts:9]AccountID:1; vFromDate; vToDate; ->arrOpenings{$k}; ->vTransferIn; ->vTransferOut; ->arrBuys{$k}; ->arrSells{$k}; ->arrBalances{$k}; ->arrDebitLCs{$k}; ->arrCreditLCs{$k}; vBranchID)
			arrTransfers{$k}:=vTransferIn-vTransferOut
			$sumOpenings:=arrOpenings{$k}
			$sumBuys:=arrBuys{$k}
			$sumSells:=arrSells{$k}
			$sumBalances:=arrBalances{$k}
			$sumDebitLCs:=arrDebitLCs{$k}
			$sumCreditLCs:=arrCreditLCs{$k}
			$sumTransfers:=arrTransfers{$k}
		End if 
		arrAccounts{$k}:=[Accounts:9]AccountID:1
		arrSubAccounts{$k}:=[Accounts:9]AccountID:1
		arrCurrencies{$k}:=[Accounts:9]Currency:6
		
		QUERY:C277([SubAccounts:112]; [SubAccounts:112]AccountID:4=[Accounts:9]AccountID:1)
		$numSubAccounts:=Records in selection:C76([SubAccounts:112])
		//fill account row
		FIRST RECORD:C50([SubAccounts:112])
		For ($j; 1; $numSubAccounts)
			$k:=listbox_appendRow(listBoxPtr)
			
			If (isUserAllowedToViewThisAccount)  // if account is for managers only but the user is not administrator then don't show the balances
				getSubAccountBalanceInDateRange([SubAccounts:112]SubAccountID:2; vFromDate; vToDate; ->arrOpenings{$k}; ->vTransferIn; ->vTransferOut; ->arrBuys{$k}; ->arrSells{$k}; ->arrBalances{$k}; ->arrDebitLCs{$k}; ->arrCreditLCs{$k}; vBranchID)
				arrTransfers{$k}:=vTransferIn-vTransferOut
				$sumOpenings:=$sumOpenings+arrOpenings{$k}
				$sumBuys:=$sumBuys+arrBuys{$k}
				$sumSells:=$sumSells+arrSells{$k}
				$sumBalances:=$sumBalances+arrBalances{$k}
				$sumDebitLCs:=$sumDebitLCs+arrDebitLCs{$k}
				$sumCreditLCs:=$sumCreditLCs+arrCreditLCs{$k}
				$sumTransfers:=$sumTransfers+arrTransfers{$k}
			End if 
			arrAccounts{$k}:=[Accounts:9]AccountID:1
			arrSubAccounts{$k}:=[SubAccounts:112]SubAccountID:2
			arrCurrencies{$k}:=[Accounts:9]Currency:6
			NEXT RECORD:C51([SubAccounts:112])
		End for 
		
		If ($numSubAccounts>=1)
			//inserting subtotal values for accounts with sub accounts
			$k:=listbox_appendRow(listBoxPtr)
			arrAccounts{$k}:=[Accounts:9]AccountID:1
			arrSubAccounts{$k}:="    subtotal "+[Accounts:9]AccountID:1
			arrOpenings{$k}:=$sumOpenings
			arrBuys{$k}:=$sumBuys
			arrSells{$k}:=$sumSells
			arrBalances{$k}:=$sumBalances
			arrCurrencies{$k}:=[Accounts:9]Currency:6
			arrDebitLCs{$k}:=$sumDebitLCs
			arrCreditLCs{$k}:=$sumCreditLCs
			arrTransfers{$k}:=$sumTransfers
		End if 
		
		If ($i%5=1)
			refreshProgressBar($progress; $i; $numAccounts)
			setProgressBarTitle($progress; "Account :"+[Accounts:9]AccountID:1)
		End if 
		
		$i:=$i+1
		NEXT RECORD:C51([Accounts:9])
		
	Until (($i>$numAccounts) | isProgressBarStopped($progress))
	HIDE PROCESS:C324($progress)
End if 