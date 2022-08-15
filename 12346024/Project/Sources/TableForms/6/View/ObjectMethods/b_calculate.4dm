If (isUserAllowedToViewProfits)
	calcCurrencyProfitVars(vFromDate; vToDate; numToBoolean(cbApplyDateRange))
	colorizeNegs(->vSalesProfitInCAD)
	colorizeNegs(->vProfitAfterFeesInCAD)
End if 
