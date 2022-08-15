//%attributes = {}

RELATE ONE:C42([Registers:10]AccountID:6)

If (Records in selection:C76([Accounts:9])=0)
	
	CREATE RELATED ONE:C65([Registers:10]AccountID:6)
	[Accounts:9]AccountID:1:=[Registers:10]AccountID:6
	[Accounts:9]Currency:6:=[Registers:10]Currency:19
	[Accounts:9]MainAccountID:2:="unknown"
	[Accounts:9]AccountDescription:17:="automatically recreated by the system"
	[Accounts:9]isFlagged:13:=True:C214
	
	SAVE RELATED ONE:C43([Registers:10]AccountID:6)
End if 