//%attributes = {}
// selectNonCashAccountsOfCurrency({Currency})
C_TEXT:C284($currency; $1)

If (Count parameters:C259=0)
	$currency:=vAccountCurrency
Else 
	$currency:=$1
End if 

QUERY:C277([Accounts:9]; [Accounts:9]isCashAccount:3=False:C215; *)
QUERY:C277([Accounts:9];  & ; [Accounts:9]Currency:6=$currency)  // filter only vAccountCurrency
