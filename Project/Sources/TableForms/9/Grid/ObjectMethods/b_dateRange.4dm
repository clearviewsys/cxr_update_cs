var vFromDate; vToDate : Date
If (Form event code:C388=On Clicked:K2:4)
	requestDateRange
	Form:C1466.fromDate:=vFromDate
	Form:C1466.toDate:=vToDate
	Form:C1466.applyDateRange:=1
	//SET TIMER(-1)
	
End if 