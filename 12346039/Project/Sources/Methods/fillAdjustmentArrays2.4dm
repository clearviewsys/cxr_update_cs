//%attributes = {}
// fillAdjustmentArrays
// fillAdjustmentArrays({currency})
// fillAdjustomer (till;true)

C_TEXT:C284($currency; $till; $1)
C_BOOLEAN:C305($dummy; $2)
initDateRangeVars

Case of 
	: (Count parameters:C259=0)
		ALL RECORDS:C47([Currencies:6])
	: (Count parameters:C259=1)
		$currency:=$1
		QUERY:C277([Accounts:9]; [Accounts:9]Currency:6=$currency)
	: (Count parameters:C259=2)
		$till:=$1
		$dummy:=$2
		selectAccountsRelatedToTill($till)
	Else 
		// nothing
End case 

initAdjustmentArrays


orderByAccounts
SELECTION TO ARRAY:C260([Accounts:9]AccountID:1; arrAccountNames)
SELECTION TO ARRAY:C260([Accounts:9]Currency:6; arrCurrencies)



C_LONGINT:C283($i; $n)
C_REAL:C285($dummy1; $dummy2)

$n:=Records in selection:C76([Accounts:9])
// resize the numeric arrays
ARRAY REAL:C219(arrAccountBalances; $n)
ARRAY REAL:C219(arrAdjustedBalances; $n)
ARRAY REAL:C219(arrOffBalances; $n)
ARRAY REAL:C219(arrRates; $n)
ARRAY REAL:C219(arrOffBalancesLC; $n)

C_REAL:C285($balance; $rate)
C_LONGINT:C283($progress)

$progress:=launchProgressBar("Filling Arrays")
For ($i; 1; $n)
	$balance:=getAccountBalance(arrAccountNames{$i}; vFromDate; vToDate; numToBoolean(cbApplyDateRange))
	getCurrencyRates(arrCurrencies{$i}; ->arrRates{$i}; ->$dummy1; ->$dummy2)
	refreshProgressBar($progress; $i; $n)
	setProgressBarTitle($progress; "Filling table for account "+arrAccountNames{$i})
	Case of 
		: (rbOpening=1)
			arrAccountBalances{$i}:=0
			arrAdjustedBalances{$i}:=$balance
			
		: (rbClosing=1)
			arrAccountBalances{$i}:=$balance
			arrAdjustedBalances{$i}:=0
			
		Else 
			arrAccountBalances{$i}:=$balance
			arrAdjustedBalances{$i}:=$balance
			
	End case 
	setOffBalanceArrayRow($i)
	
End for 
HIDE PROCESS:C324($progress)
