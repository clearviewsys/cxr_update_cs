//%attributes = {}
// FillOpeningArrays

C_TEXT:C284($currency; $1)

ARRAY TEXT:C222(arrAccountNames; 0)
ARRAY REAL:C219(arrClosings; 0)
ARRAY REAL:C219(arrOpenings; 0)
ARRAY REAL:C219(arrOffBalances; 0)
ARRAY TEXT:C222(arrCurrencies; 0)

C_TEXT:C284($till)
$till:=requestTillNo("Please pick the till to open:")
selectAccountsRelatedToTill($till)

orderByAccounts
SELECTION TO ARRAY:C260([Accounts:9]AccountID:1; arrAccountNames)
SELECTION TO ARRAY:C260([Accounts:9]Currency:6; arrCurrencies)

C_LONGINT:C283($i; $n)

$n:=Records in selection:C76([Accounts:9])
// resize the numeric arrays
ARRAY REAL:C219(arrClosings; $n)
ARRAY REAL:C219(arrOpenings; $n)
ARRAY REAL:C219(arrOffBalances; $n)

C_REAL:C285($balance)
For ($i; 1; $n)
	$balance:=getAccountBalance(arrAccountNames{$i})
	arrClosings{$i}:=$balance
	arrOpenings{$i}:=$balance
End for 