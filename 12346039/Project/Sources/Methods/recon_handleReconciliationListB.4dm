//%attributes = {}
C_LONGINT:C283(cbdisplayUnreconciled)

If (cbdisplayUnreconciled=0)
	selectRegistersInDateRange([Accounts:9]AccountID:1; vFromDate; vToDate)
Else 
	selectUnreconciledRegistersFor([Accounts:9]AccountID:1; vFromDate; vToDate)
End if 

If (VBRANCHID#"")
	QUERY SELECTION:C341([Registers:10]; [Registers:10]BranchID:39=vBranchID)
End if 

orderByRegisters
fillReconciliationListBox
fillRunningBalanceArray(->arrDebits; ->arrCredits; ->arrBalances; vSumOpeningBalance)
calculateReconcileVars
