If ((Form event code:C388=On Clicked:K2:4) & (isUserManager))
	QUERY:C277([Accounts:9]; [Accounts:9]isHidden:21=True:C214)
	POST OUTSIDE CALL:C329(Current process:C322)
	//orderByAccounts 
End if 