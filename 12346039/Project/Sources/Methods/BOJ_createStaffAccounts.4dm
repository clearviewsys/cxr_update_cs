//%attributes = {"executedOnServer":true}

C_LONGINT:C283($i; $n)
$n:=Records in selection:C76([Customers:3])

READ WRITE:C146([Accounts:9])
READ ONLY:C145([Customers:3])

For ($i; 1; $n)
	GOTO SELECTED RECORD:C245([Customers:3]; $i)
	
	CREATE RECORD:C68([Accounts:9])
	[Accounts:9]AccountID:1:=": "+[Customers:3]FullName:40+" : "+[Customers:3]ExternalAccountNo:96
	[Accounts:9]MainAccountID:2:="Member Accounts"
	[Accounts:9]CustomerID:20:=[Customers:3]CustomerID:1
	
	SAVE RECORD:C53([Accounts:9])
	UNLOAD RECORD:C212([Accounts:9])
	NEXT RECORD:C51([Customers:3])
End for 
READ ONLY:C145([Accounts:9])
