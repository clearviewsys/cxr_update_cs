//%attributes = {"shared":true}
C_DATE:C307(vfromDate; vToDate)
C_LONGINT:C283(vRowNumber)
C_LONGINT:C283($OK)

If (isUserAllowedToPrintReports)
	
	//vFromDate:=Current date
	//vToDate:=Current date
	
	If (Count parameters:C259=0)
		$OK:=requestDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; True:C214)
	End if 
	
	If ($OK=1)
		printSettings
		If (OK=1)
			
			selectActiveAccountsDuring(vFromDate; vToDate)
			acc_printFormAccountPositions
			
		End if 
	End if 
Else 
	myAlert("I am sorry but you cannot print this report.")
End if 
