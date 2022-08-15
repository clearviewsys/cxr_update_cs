If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(arrAccountType; 6)
	arrAccountType:=1
End if 

If (Form event code:C388#On Load:K2:1)
	selectAccountsInDateRange(vFromDate; vToDate; numToBoolean(cbApplyDateRange))
	
	If (Self:C308->#1)
		QUERY SELECTION:C341([Accounts:9]; [Accounts:9]AccountType:5=arrAccountType{arrAccountType})
		orderByAccounts
	End if 
	filterHiddenAccounts
	//acc_fillAccouctsListBox 
	arrMainAccounts:=0
	arrCurrencies:=0
	POST OUTSIDE CALL:C329(Current process:C322)
	
End if 