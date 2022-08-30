//%attributes = {"shared":true}
C_DATE:C307(vfromDate; vToDate)
C_LONGINT:C283(vRowNumber)

If (isUserAllowedToPrintReports)
	
	vFromDate:=Current date:C33
	vToDate:=Current date:C33
	
	If (Count parameters:C259=0)
		requestDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; True:C214)
	End if 
	
	If (OK=1)
		printSettings
		
		If (OK=1)
			selectActiveAccountsDuring(vFromDate; vToDate)
			acc_printFormAccountBalances
			
		End if 
	End if 
	
Else 
	myAlert("Please ask the administrator to grant you access to printing reports.")
End if 

