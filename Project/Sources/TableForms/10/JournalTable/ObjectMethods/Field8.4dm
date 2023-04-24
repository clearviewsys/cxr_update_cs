handleToDateObject(Self:C308)

If (Form event code:C388=On Data Change:K2:15)
	selectAccountsInDateRange(vFromDate; vToDate; numToBoolean(cbApplyDateRange))
	reg_fillRegistersListBox
End if 