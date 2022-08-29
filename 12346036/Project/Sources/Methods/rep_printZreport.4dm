//%attributes = {"shared":true}
C_DATE:C307(vDate)
C_TIME:C306(vTime)
C_TEXT:C284(sv_reportType)

vDate:=Current date:C33
vTime:=Current time:C178
sv_reportType:="Z-Report"

C_LONGINT:C283(vRowNumber)

If (isUserAllowedToPrintReports)
	
	vFromDate:=Current date:C33
	vToDate:=Current date:C33
	requestDateRange
	
	
	If (OK=1)
		printSettings
		
		If (OK=1)
			CONFIRM:C162("Print all accounts or active accounts during the date range?"; "All Accounts"; "Active Accounts")
			If (OK=1)
				selectActiveAccountsDuring(!00-00-00!; vToDate)
			Else 
				selectActiveAccountsDuring(vFromDate; vToDate)
			End if 
			
			If (Records in selection:C76([Registers:10])>0)
				acc_printFormZreport
			Else 
				myAlert("Nothing to print.")
			End if 
			
		End if 
	End if 
	
Else 
	myAlert("You are not allowed to print this report.")
End if 

