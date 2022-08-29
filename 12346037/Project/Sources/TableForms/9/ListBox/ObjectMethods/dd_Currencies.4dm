handleCurrencyPullDown(Self:C308; ->[Accounts:9]; ->[Accounts:9]Currency:6)


If (Form event code:C388#On Load:K2:1)
	filterHiddenAccounts
	POST OUTSIDE CALL:C329(Current process:C322)
End if 