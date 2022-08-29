//%attributes = {"shared":true}
//rep_printAccountsBySelector ({fromDate;ToDate})

C_DATE:C307(vfromDate; vToDate)
C_LONGINT:C283(vRowNumber)
C_LONGINT:C283($OK)

If (isUserAllowedToPrintReports)
	//vFromDate:=Current date
	//vToDate:=Current date
	printReportUsingAccountSelector("acc_printFormAccountPositions")
	
Else 
	myAlert("I am sorry but you cannot print this report.")
End if 
