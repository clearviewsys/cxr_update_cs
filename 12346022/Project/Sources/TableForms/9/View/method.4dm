handleViewFormMethod

C_OBJECT:C1216($summary; $es)

If (Form event code:C388=On Load:K2:1)
	//SET FIELD RELATION([Registers]CustomerID;Automatic;Manual)  // activate the automatic relation 
	
End if 

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	// #ORDA 
	// The following code was buggy: Bug reported by 
	//$es:=ds.Registers.query("AccountID = :1";[Accounts]AccountID)
	//If ($es.length>0)
	//If (vBranchID#"")
	//$es:=$es.query("BranchID = :1";vBranchID)
	//End if 
	//If (cbApplyDateRange=1)
	//$es:=$es.query("RegisterDate >= :1 AND RegisterDate <= :2";vFromDate;vToDate)
	//End if 
	//USE ENTITY SELECTION($es)
	//orderByRegisters 
	//Else 
	//REDUCE SELECTION([Registers];0)
	//End if 
	
	// This 4D Code works better than the ORDA code, not sure why TB: 
	READ ONLY:C145([Registers:10])
	QUERY:C277([Registers:10]; [Registers:10]AccountID:6=[Accounts:9]AccountID:1)
	If (cbApplyDateRange=1)
		QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate; *)
		QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
	End if 
	orderByRegisters
	
	showObjectOnTrue([Accounts:9]isRestrictedToManagers:14; "isRestricted")
	If (isUserAllowedToViewThisAccount)
		//handleAccountsViewRegisters 
		$summary:=New object:C1471
		
		getAccountBalanceInDateRgORDA([Accounts:9]AccountID:1; vFromDate; vToDate; numToBoolean(cbApplyDateRange); vBranchID; $summary)
		Form:C1466.openingBalance:=$summary.openingBalance
		Form:C1466.sumBuys:=$summary.sumBuys
		Form:C1466.sumSells:=$summary.sumSells
		Form:C1466.transferIn:=$summary.transferIn
		Form:C1466.transferOut:=$summary.transferOut
		Form:C1466.balance:=$summary.balance
		Form:C1466.sumDebitLC:=$summary.sumDebitLC
		Form:C1466.sumCreditLC:=$summary.sumCreditLC
	End if 
	
	//REDRAW(mainListBox)
End if 

If (Form event code:C388=On Unload:K2:2)
	SET FIELD RELATION:C919([Registers:10]CustomerID:5; Manual:K51:3; Manual:K51:3)
End if 