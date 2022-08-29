//%attributes = {"shared":true}
C_DATE:C307(vDate)
C_TIME:C306(vTime)
C_TEXT:C284(sv_reportType)


vDate:=Current date:C33
vTime:=Current time:C178
sv_reportType:="X-Report"

C_LONGINT:C283(vRowNumber)

If (isUserAllowedToPrintReports)
	
	vFromDate:=Current date:C33
	vToDate:=Current date:C33
	//requestDateRange
	
	If (OK=1)
		printSettings
		
		If (OK=1)
			CONFIRM:C162("Print all accounts or active accounts only?"; "Active Only"; "All Accounts")
			If (OK=1)
				selectActiveAccountsDuring(vFromDate; vToDate)
			Else 
				selectActiveAccountsDuring(!00-00-00!; vToDate)
			End if 
			acc_printFormXreport
			
		End if 
	End if 
	
Else 
	myAlert("You are not allowed to print the X report.")
End if 

