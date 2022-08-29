//%attributes = {"shared":true}


C_POINTER:C301($tablePtr)
C_TEXT:C284($formName)
C_DATE:C307(vfromDate; vToDate)
C_LONGINT:C283($vlRecord)
vFromDate:=Current date:C33
vToDate:=Current date:C33
requestDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2)

$formName:="rep_CashAccounts"

C_TEXT:C284($till)
$till:=requestTillNo("Which till to print? ")
selectRegistersByTillNo($till; vFromDate; vToDate)

If (OK=1)
	READ ONLY:C145([Accounts:9])
	
	RELATE ONE SELECTION:C349([Registers:10]; [Accounts:9])  // select only the currencies that are in that date range
	orderByTable(->[Accounts:9])
	PRINT SETTINGS:C106  // Display Printing dialog boxes
	If (OK=1)
		For ($vlRecord; 1; Records in selection:C76([Accounts:9]))
			LOAD RECORD:C52([Accounts:9])
			
			// 1ST : load all the registers for this account 
			relateMany(->[Registers:10]; ->[Registers:10]AccountID:6; ->[Accounts:9]AccountID:1)  // load all the registers for this account
			
			// 2ND : constrain the ending period
			QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
			
			// 3RD: calculate the sum from beginning to toDate
			getRegisterSums(->vSumTotalDebitsLocal; ->vSumTotalCreditsLocal; ->vSumTotalBalanceLocal; ->vSumTotalDebits; ->vSumTotalCredits; ->vSumTotalBalance; ->vSumTotalFees)
			
			// 4TH: constrain the starting period
			QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate)
			
			// 5TH: calculate the other sums
			getRegisterSums(->vSumDebitsLocal; ->vSumCreditsLocal; ->vSumBalanceLocal; ->vSumDebits; ->vSumCredits; ->vSumBalance; ->vSumFees)
			
			calcSummaryVars
			
			Print form:C5([Accounts:9]; $formName)  // Use one form for the details 
			NEXT RECORD:C51([Accounts:9])
		End for 
		//Print form([Accounts];$formName+"_Sums")  ` Use another form for the sum
		PAGE BREAK:C6  // Make sure the last page is printed
	End if 
End if 