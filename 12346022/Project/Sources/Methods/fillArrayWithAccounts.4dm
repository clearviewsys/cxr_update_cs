//%attributes = {}
// fillArrayWithBankAccounts( ->array; currencyCode;{bool:foreignAccount;{channel}})

C_TEXT:C284($2; $4)
C_BOOLEAN:C305($3; $external)
C_POINTER:C301($1)
Case of 
	: (Count parameters:C259=2)
		QUERY:C277([Accounts:9]; [Accounts:9]Currency:6=$2)
	: (Count parameters:C259=3)
		$external:=$3
		QUERY:C277([Accounts:9]; [Accounts:9]Currency:6=$2; *)
		QUERY:C277([Accounts:9];  & ; [Accounts:9]isForeignAccount:15=$external)
	: (Count parameters:C259=4)
		QUERY:C277([Accounts:9]; [Accounts:9]Currency:6=$2; *)
		QUERY:C277([Accounts:9];  & ; [Accounts:9]AgentID:16=$4)
End case 

ORDER BY:C49([Accounts:9]; [Accounts:9]AccountID:1)
SELECTION TO ARRAY:C260([Accounts:9]AccountID:1; $1->)
If (Records in selection:C76([Accounts:9])>0)
	
	$1->{0}:=$1->{1}  // automatically choose the first item

End if 

