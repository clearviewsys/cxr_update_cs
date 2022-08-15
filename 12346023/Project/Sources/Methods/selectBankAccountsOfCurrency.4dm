//%attributes = {}
// selectBankAccountsOfCurrency({Currency}; isChequing: int)
// updated by @tiran on July 21 / 2020 
// the new method can filter for chequing accounts

C_TEXT:C284($currency; $1)
C_LONGINT:C283($isChequing; $2)  // 0 = both ; 1 = isChequing ; 2 = is Not chequing

$isChequing:=0
Case of 
	: (Count parameters:C259=0)
		$currency:=vAccountCurrency
	: (Count parameters:C259=1)
		$currency:=$1
	: (Count parameters:C259=2)
		$currency:=$1
		$isChequing:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
	: ($isChequing=1)  // is Chequing
		QUERY:C277([Accounts:9]; [Accounts:9]isBankAccount:7=True:C214; *)
		QUERY:C277([Accounts:9];  & ; [Accounts:9]isChequing:43=True:C214; *)
		QUERY:C277([Accounts:9];  & ; [Accounts:9]Currency:6=$currency; *)
		QUERY:C277([Accounts:9];  & ; [Accounts:9]isHidden:21=False:C215)
		
	: ($isChequing=2)  // is not chequing
		QUERY:C277([Accounts:9]; [Accounts:9]isBankAccount:7=True:C214; *)
		QUERY:C277([Accounts:9];  & ; [Accounts:9]isChequing:43=False:C215; *)
		QUERY:C277([Accounts:9];  & ; [Accounts:9]Currency:6=$currency; *)  // filter only vAccountCurrency
		QUERY:C277([Accounts:9];  & ; [Accounts:9]isHidden:21=False:C215)
	Else 
		QUERY:C277([Accounts:9]; [Accounts:9]isBankAccount:7=True:C214; *)
		QUERY:C277([Accounts:9];  & ; [Accounts:9]Currency:6=$currency; *)
		QUERY:C277([Accounts:9];  & ; [Accounts:9]isHidden:21=False:C215)
		
End case 

