//%attributes = {}
// queryCashAccounts (onSelecton)

// WARNING: DO NOT RENAME THIS PROCEDURE BECAUSE IT IS BEING CALLED FROM

// PICKACCOUNTS, or other methods

C_BOOLEAN:C305($onSelection; $1)

Case of 
	: (Count parameters:C259=0)
		$onSelection:=False:C215
	: (Count parameters:C259=1)
		$onSelection:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($onSelection)
	QUERY SELECTION:C341([Accounts:9]; [Accounts:9]isCashAccount:3=True:C214)
Else 
	QUERY:C277([Accounts:9]; [Accounts:9]isCashAccount:3=True:C214)
End if 