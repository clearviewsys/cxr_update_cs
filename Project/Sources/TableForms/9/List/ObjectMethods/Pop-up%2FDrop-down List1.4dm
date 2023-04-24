If (Self:C308->=1)
	allRecordsAccounts
Else 
	QUERY:C277([Accounts:9]; [Accounts:9]AccountType:5=Self:C308->{Self:C308->})
	orderByAccounts
End if 
POST OUTSIDE CALL:C329(Current process:C322)

