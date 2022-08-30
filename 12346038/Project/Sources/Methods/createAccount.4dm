//%attributes = {}
// CreateAccount (AccountID; mainAccountID; currency; isReserved; isAdmin)
// POST : destroys the current selection in [ACCOUNTS]

C_TEXT:C284($1; $2; $3)
C_BOOLEAN:C305($4; $5)

C_TEXT:C284($accountID; $mainAccountID; $currency)
C_BOOLEAN:C305($isReserved; $isForAdminOnly)
$accountID:=$1
$mainAccountID:=$2
$currency:=$3
$isReserved:=$4
$isForAdminOnly:=$5

READ ONLY:C145([Accounts:9])
QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=$accountID)
If (Records in selection:C76([Accounts:9])=0)
	READ WRITE:C146([Accounts:9])
	CREATE RECORD:C68([Accounts:9])
	[Accounts:9]AccountID:1:=$accountID
	[Accounts:9]MainAccountID:2:=$mainAccountID
	RELATE ONE:C42([Accounts:9]MainAccountID:2)
	[Accounts:9]AccountType:5:=[MainAccounts:28]AccountType:4
	[Accounts:9]Currency:6:=$currency
	[Accounts:9]isDebit:11:=[MainAccounts:28]isDebit:5
	If (([Accounts:9]MainAccountID:2=c_Cash) | ([Accounts:9]MainAccountID:2=c_ForeignCurrencies))
		[Accounts:9]isCashAccount:3:=True:C214
	Else 
		[Accounts:9]isCashAccount:3:=False:C215
	End if 
	If ([Accounts:9]MainAccountID:2=c_Banks)
		[Accounts:9]isBankAccount:7:=True:C214
	Else 
		[Accounts:9]isBankAccount:7:=False:C215
	End if 
	[Accounts:9]isReservedBySystem:12:=$isReserved
	[Accounts:9]isRestrictedToManagers:14:=$isForAdminOnly
	[Accounts:9]AccountCode:4:=""
	SAVE RECORD:C53([Accounts:9])
	UNLOAD RECORD:C212([Accounts:9])
	READ ONLY:C145([Accounts:9])
End if 