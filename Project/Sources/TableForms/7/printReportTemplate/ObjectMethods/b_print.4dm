C_POINTER:C301(currentTablePtr)

If (vReportNames>0)
	FORM SET OUTPUT:C54(currentTablePtr->; vReportNames{vReportNames})
	If (vPageSetup=0)
		PRINT RECORD:C71(currentTablePtr->; >)
	Else 
		PRINT RECORD:C71(currentTablePtr->)
	End if 
	
Else 
	myAlert("Please select a form for printing first")
End if 