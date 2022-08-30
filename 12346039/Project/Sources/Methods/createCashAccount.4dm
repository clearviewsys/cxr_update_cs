//%attributes = {}
// CreateCashAccount (Currency:String;BankName;$isForAdmin)
C_TEXT:C284($1; $2; $currency; $bankName)
C_TEXT:C284($parentAccount)
C_BOOLEAN:C305($3; $isForAdminOnly)

$currency:=$1

If ($currency=<>baseCurrency)
	$parentAccount:=c_Cash
Else 
	$parentAccount:=c_ForeignCurrencies
End if 

Case of 
	: (Count parameters:C259=1)
		createAccount(makeCashAccountID($currency); $parentAccount; $currency; True:C214; False:C215)
	: (Count parameters:C259=2)
		$bankName:=$2
		createAccount(makeCashAccountID($currency; $bankName); $parentAccount; $currency; True:C214; False:C215)
	: (Count parameters:C259=3)
		$bankName:=$2
		$isForAdminOnly:=$3
		createAccount(makeCashAccountID($currency; $bankName); $parentAccount; $currency; True:C214; $isForAdminOnly)
	Else 
		myAlert("invalid number of parameters called: createCashAccount")
End case 