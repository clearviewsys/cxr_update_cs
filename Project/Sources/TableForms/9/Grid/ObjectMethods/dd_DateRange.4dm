
handleDropDown_DateRange(Self:C308)

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	
	Form:C1466.fromDate:=vFromDate
	Form:C1466.toDate:=vToDate
	Form:C1466.applyDateRange:=1
End if 