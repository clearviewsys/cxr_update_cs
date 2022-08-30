C_LONGINT:C283(vRowNumber; CBAPPLYDATERANGE)
C_LONGINT:C283($OK)

If (isUserAllowedToPrintReports)
	If (CBAPPLYDATERANGE=0)
		vFromDate:=nullDate
		vToDate:=Current date:C33
	End if 
	
	If ((OK=1) & (Records in selection:C76([Registers:10])>0))
		
		RELATE ONE SELECTION:C349([Registers:10]; [Accounts:9])  // map back all the registers into the accounts to filter out the accounts that were
		orderByAccounts
		
		If (Records in selection:C76([Accounts:9])>0)  // THE PRINTING PROCESS
			printSettings
			If (OK=1)
				acc_printFormAccountPositions
			End if 
			
		Else 
			myAlert("No records to print.")
		End if 
		
	End if 
	
Else 
	ALERT:C41("Sorry, but you are not authorized to print this report.")
End if 
