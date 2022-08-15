//%attributes = {"shared":true}
// rep_printTillSummary
C_DATE:C307(vfromDate; vToDate)
C_LONGINT:C283(vRowNumber)
C_TEXT:C284($till)


$till:=requestTillNo

requestDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; True:C214)

If (OK=1)
	If (isUserAllowedToPrintReports)
		
		printSettings
		If (OK=1)
			selectRegistersByTillNo($till; vFromDate; vToDate)
			
			acc_printFormAccountBalances
			
		End if 
		
	Else 
		myAlert("Please ask the administrator to grant you access to printing reports.")
	End if 
End if 

