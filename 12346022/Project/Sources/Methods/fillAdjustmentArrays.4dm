//%attributes = {}
//fillAdjustmentArrays({currency})

C_TEXT:C284($currency; $1)

Case of 
	: (Count parameters:C259=0)
		ALL RECORDS:C47([Currencies:6])
	: (Count parameters:C259=1)
		$currency:=$1
		QUERY:C277([Accounts:9]; [Accounts:9]Currency:6=$currency)
End case 

initAdjustmentArrays


orderByAccounts
SELECTION TO ARRAY:C260([Accounts:9]AccountID:1; arrAccountNames)
SELECTION TO ARRAY:C260([Accounts:9]Currency:6; arrCurrencies)

C_LONGINT:C283($i; $n)

$n:=Records in selection:C76([Accounts:9])
// resize the numeric arrays
ARRAY REAL:C219(arrAccountBalances; $n)
ARRAY REAL:C219(arrAdjustedBalances; $n)
ARRAY REAL:C219(arrOffBalances; $n)
ARRAY REAL:C219(arrRates; $n)
ARRAY REAL:C219(arrOffBalancesLC; $n)

C_REAL:C285($balance)
For ($i; 1; $n)
	$balance:=getAccountBalance(arrAccountNames{$i})
	arrAccountBalances{$i}:=$balance
	arrAdjustedBalances{$i}:=$balance
	setOffBalanceArrayRow($i)
End for 