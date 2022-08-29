//%attributes = {"shared":true}
//rep_printAccountsByQuery ({fromDate;ToDate})

C_DATE:C307(vfromDate; vToDate)
C_LONGINT:C283(vRowNumber)
C_LONGINT:C283($OK)

If (isUserAllowedToPrintReports)
	C_LONGINT:C283($WinRef)
	FORM SET INPUT:C55([Registers:10]; "search")  // Switch to query form
	$WinRef:=Open form window:C675([Registers:10]; "search"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	QUERY BY EXAMPLE:C292([Registers:10])
	requestDateRange
	
	If ((OK=1) & (Records in selection:C76([Registers:10])>0))
		
		//selectDateRangeTable (->[Registers];->[Registers]RegisterDate;nullDate ;vToDate;True)
		
		// all additional filters shall be here, such as filter by branch or by user ID
		// at this point all the related journal registers are selected
		
		RELATE ONE SELECTION:C349([Registers:10]; [Accounts:9])  // map back all the registers into the accounts to filter out the accounts that were
		// not touched since the beginning
		orderByAccounts
		
		If (Records in selection:C76([Accounts:9])>0)  // THE PRINTING PROCESS
			printSettings
			If (OK=1)
				acc_printFormAccountPositions
			End if 
			
		Else 
			myAlert("No matching records to print.")
		End if 
		
	End if 
	
Else 
	myAlert("I am sorry but you cannot print this report.")
End if 
