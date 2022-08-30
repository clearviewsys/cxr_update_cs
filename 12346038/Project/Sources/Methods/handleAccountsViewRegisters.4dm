//%attributes = {}
C_TEXT:C284(vCurrency; vAccount)
C_DATE:C307(vFromDate; vToDate; $vFromDate; $vToDate)
C_LONGINT:C283(cbApplyDateRange)

// Sum Variable Declarations
C_REAL:C285(vSumCredits; vSumDebits; vSumBalance)
C_REAL:C285(vSumOpeningCredits; vSumOpeningDebits; vSumOpeningBalance)
C_REAL:C285(vSumTotalCredits; vSumTotalDebits; vSumTotalBalance)

C_REAL:C285(vSumCreditsLocal; vSumDebitsLocal; vSumBalanceLocal)
C_REAL:C285(vSumOpeningCreditsLocal; vSumOpeningDebitsLocal; vSumOpeningBalanceLocal)
C_REAL:C285(vSumTotalCreditsLocal; vSumTotalDebitsLocal; vSumTotalBalanceLocal)

// Fees Variable Declarations
C_REAL:C285(vSumFees; vSumOpeningFees; vSumTotalFees)

vSumCredits:=0
vSumDebits:=0
vSumBalance:=0
vSumOpeningCredits:=0
vSumOpeningDebits:=0
vSumOpeningBalance:=0
vSumTotalCredits:=0
vSumTotalDebits:=0
vSumTotalBalance:=0
vSumCreditsLocal:=0
vSumDebitsLocal:=0
vSumBalanceLocal:=0
vSumOpeningCreditsLocal:=0
vSumOpeningDebitsLocal:=0
vSumOpeningBalanceLocal:=0
vSumTotalCreditsLocal:=0
vSumTotalDebitsLocal:=0
vSumTotalBalanceLocal:=0
vSumFees:=0
vSumOpeningFees:=0
vSumTotalFees:=0


vCurrency:=[Accounts:9]Currency:6

If (cbApplyDateRange=1)
	$vFromDate:=vFromDate
	$vToDate:=vToDate
	// 1ST : load all the registers for this account 
	relateMany(->[Registers:10]; ->[Registers:10]AccountID:6; ->[Accounts:9]AccountID:1)  // load all the registers for this account
	
	// 2ND : constrain the ending period
	QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=$vToDate)
	
	// 3RD: calculate the sum from beginning to toDate
	getRegisterSums(->vSumTotalDebitsLocal; ->vSumTotalCreditsLocal; ->vSumTotalBalanceLocal; ->vSumTotalDebits; ->vSumTotalCredits; ->vSumTotalBalance; ->vSumTotalFees)
	
	// 4TH: constrain the starting period
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$vFromDate)
	
	// 5TH: calculate the other sums
	getRegisterSums(->vSumDebitsLocal; ->vSumCreditsLocal; ->vSumBalanceLocal; ->vSumDebits; ->vSumCredits; ->vSumBalance; ->vSumFees)
	
	calcSummaryVars
	
Else 
	
	// 1ST : load all the registers for this account 
	relateMany(->[Registers:10]; ->[Registers:10]AccountID:6; ->[Accounts:9]AccountID:1)  // load all the registers for this account
	
	// 3RD: calculate the sum from beginning to toDate
	getRegisterSums(->vSumTotalDebitsLocal; ->vSumTotalCreditsLocal; ->vSumTotalBalanceLocal; ->vSumTotalDebits; ->vSumTotalCredits; ->vSumTotalBalance; ->vSumTotalFees)
End if 


orderByRegisters
