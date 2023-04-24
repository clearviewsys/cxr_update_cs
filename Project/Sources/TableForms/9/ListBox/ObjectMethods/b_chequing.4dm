//selectAccountsInDateRange (vFromDate;vToDate;numToBoolean (cbApplyDateRange))
QUERY:C277([Accounts:9]; [Accounts:9]isChequing:43=True:C214)
filterHiddenAccounts
orderByAccounts
POST OUTSIDE CALL:C329(Current process:C322)
