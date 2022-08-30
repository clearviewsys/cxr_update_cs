If ((Form event code:C388=On Display Detail:K2:22) & (tabCurrencies=2))
	// THE REASON I NEED TO CHECK tabCurrencies
	//is that teh next query will destroy the selection of record in registers
	// and this method gets executed after the form method click has been executed
	// therefore switching from tab 2 to tab 1 will loose the selection of records
	C_REAL:C285(vDebits; vCredits; vBalance; vDebitsLocal; vCreditsLocal; vBalanceLocal)
	
	getAccountTotals([Accounts:9]AccountID:1; ->vDebits; ->vCredits; ->vBalance; ->vDebitsLocal; ->vCreditsLocal; ->vBalanceLocal; vFromDate; vToDate; numToBoolean(cbApplyDateRange))
	colourizeLineBG("BackStripe")
End if 