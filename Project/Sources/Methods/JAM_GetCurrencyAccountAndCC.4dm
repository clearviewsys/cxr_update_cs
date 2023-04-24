//%attributes = {}
// JAM_GetCurrencyAccountAndCC ($register; $ptrAccount; $ptrCC)
// Get Account Number and Cost Center of the Account related to the transaction

C_OBJECT:C1216($1; $register; $account)
C_POINTER:C301($2; $ptrAccount; $3; $ptrCC)

Case of 
	: (Count parameters:C259=3)
		
		$register:=$1
		$ptrAccount:=$2
		$ptrCC:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$account:=ds:C1482.Accounts.query("AccountID = :1"; $register.AccountID).first()

$ptrAccount->:=$account.AccountCode
$ptrCC->:=$account.PL_Group

