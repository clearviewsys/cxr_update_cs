//%attributes = {}
C_DATE:C307(vfromdate; vToDate)

If (isUserAdministrator)
	
	requestDateRange
	If (OK=1)
		selectDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; vFromDate; vToDate; False:C215)
		
		If (Records in selection:C76([Registers:10])>0)
			updateTableUsingMethod(->[Registers:10]; "fixRegisterRow"; False:C215)
		End if 
	End if 
	
End if 