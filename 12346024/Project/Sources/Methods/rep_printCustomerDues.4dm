//%attributes = {"shared":true}

If (isUserAllowedToPrintReports)
	C_REAL:C285(vSumDebitsLocal; vSumCreditsLocal; vBalanceLocal)
	C_REAL:C285(vTotalDebitsLocal; vTotalCreditsLocal; vTotalBalanceLocal)
	vSumDebitsLocal:=0
	vSumCreditsLocal:=0
	vBalanceLocal:=0
	vTotalDebitsLocal:=0
	vTotalCreditsLocal:=0
	vTotalBalanceLocal:=0
	
	selectCustomersWOutstandingBala
	C_LONGINT:C283($n; $i)
	$n:=Records in selection:C76([Customers:3])
	If ($n>0)
		READ ONLY:C145([Customers:3])
		FIRST RECORD:C50([Customers:3])
		PRINT SETTINGS:C106
		If (OK=1)
			Print form:C5([Customers:3]; "rep_CustomerDues_H")
			For ($i; 1; $n)
				LOAD RECORD:C52([Customers:3])
				
				// first find all accounts that are receivale and payable
				selectAccountsPending
				RELATE MANY SELECTION:C340([Registers:10]AccountID:6)  // reverse map to all registers linked to the pending accounts
				
				// filter this customer only (we need the receivables for this customer only)
				QUERY SELECTION:C341([Registers:10]; [Registers:10]CustomerID:5=[Customers:3]CustomerID:1)
				orderByRegisters
				C_REAL:C285(vSumDebitsLocal; vSumCreditsLocal; vBalanceLocal)
				getRegisterSums(->vSumDebitsLocal; ->vSumCreditsLocal; ->vBalanceLocal)
				
				accumulateReal(->vTotalDebitsLocal; vSumDebitsLocal)
				accumulateReal(->vTotalCreditsLocal; vSumCreditsLocal)
				accumulateReal(->vTotalBalanceLocal; vBalanceLocal)
				
				Print form:C5([Customers:3]; "rep_CustomerDues")
				NEXT RECORD:C51([Customers:3])
			End for 
			Print form:C5([Customers:3]; "rep_CustomerDues_F")
		End if 
	End if 
Else 
	myAlert("Sorry, you are not authorized to print this report. ")
End if 

