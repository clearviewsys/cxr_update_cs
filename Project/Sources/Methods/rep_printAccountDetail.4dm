//%attributes = {"shared":true}
C_TEXT:C284($accountID)


If (isUserAllowedToPrintReports)
	pickAccounts(->$accountID; "allRecordsAccounts"; "Please select an Account.")
	
	If (OK=1)
		requestDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; True:C214)
		If (OK=1)
			QUERY SELECTION:C341([Registers:10]; [Registers:10]AccountID:6=$accountID)
			ACCUMULATE:C303([Registers:10]Debit:8; [Registers:10]Credit:7)
			BREAK LEVEL:C302(2)
			
			printTable(->[Registers:10]; "printAccounts"; ->[Registers:10]AccountID:6; ->[Registers:10]RegisterDate:2; ->[Registers:10]RegisterID:1)
		End if 
	End if 
Else 
	myAlert_AccessDenied
	
End if 


