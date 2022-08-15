If (Self:C308->=1)
	allRecordsMainAccounts
Else 
	QUERY:C277([MainAccounts:28]; [MainAccounts:28]AccountType:4=Self:C308->{Self:C308->})
	orderByMainAccounts
End if 
POST OUTSIDE CALL:C329(Current process:C322)