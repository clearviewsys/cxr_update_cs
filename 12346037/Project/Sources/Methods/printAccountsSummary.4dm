//%attributes = {}


C_POINTER:C301($tablePtr)
C_TEXT:C284($formName)
C_DATE:C307(vfromDate; vToDate)
C_LONGINT:C283($vlRecord)

$formName:="rep_summaryVars"


requestDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2)

If (OK=1)
	READ ONLY:C145([Accounts:9])
	
	RELATE ONE SELECTION:C349([Registers:10]; [Accounts:9])  // select only the currencies that are in that date range
	orderByTable(->[Accounts:9])
	PRINT SETTINGS:C106  // Display Printing dialog boxes
	If (OK=1)
		For ($vlRecord; 1; Records in selection:C76([Accounts:9]))
			LOAD RECORD:C52([Accounts:9])
			calcAccountsRepLineVars
			
			Print form:C5([Accounts:9]; $formName)  // Use one form for the details 
			NEXT RECORD:C51([Accounts:9])
		End for 
		//Print form([Accounts];$formName+"_Sums")  ` Use another form for the sum
		PAGE BREAK:C6  // Make sure the last page is printed
	End if 
End if 