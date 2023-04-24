//%attributes = {}
handleViewFormMethod

C_OBJECT:C1216($summary; $es)

If (Form event code:C388=On Load:K2:1)
	//SET FIELD RELATION([Registers]CustomerID;Automatic;Manual)  // activate the automatic relation 
	Form:C1466.marketRate:=0
	Form:C1466.marketRateInverse:=0
	Form:C1466.marketValue:=0
	
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
	
	// This 4D Code works better than the ORDA code, not sure why TB: Probably due to the Date bug in older version of ORDA
	
	
	showObjectOnTrue([Accounts:9]isRestrictedToManagers:14; "isRestricted")
	If (isUserAllowedToViewThisAccount)
		
		READ ONLY:C145([Registers:10])
		If (cbApplyDateRange=0)
			If (vBranchID="")
				QUERY:C277([Registers:10]; [Registers:10]AccountID:6=[Accounts:9]AccountID:1)
			Else 
				QUERY:C277([Registers:10]; [Registers:10]AccountID:6=[Accounts:9]AccountID:1; *)
				QUERY:C277([Registers:10]; [Registers:10]BranchID:39=vBranchID)
			End if 
		Else 
			QUERY:C277([Registers:10]; [Registers:10]AccountID:6=[Accounts:9]AccountID:1; *)
			If (vBranchID#"")
				QUERY:C277([Registers:10]; [Registers:10]BranchID:39=vBranchID; *)
			End if 
			QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate; *)
			QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2<=vToDate)
		End if 
		orderByRegisters
		
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
		Form:C1466.sumFees:=$summary.sumFees
		Form:C1466.sumGains:=$summary.sumGains
		
		var $ccy : 4D:C1709.Entity
		$ccy:=ds:C1482.Currencies.query("ISO4217= :1"; [Accounts:9]Currency:6).first()
		
		If ($ccy#Null:C1517)
			Form:C1466.marketRate:=$ccy.SpotRateLocal
			Form:C1466.marketRateInverse:=$ccy.spotRateInverse
			Form:C1466.marketValue:=Form:C1466.balance*Form:C1466.marketRate
		Else 
			Form:C1466.marketRate:=0
			Form:C1466.marketRateInverse:=0
			Form:C1466.marketValue:=0
		End if 
	End if 
	
	//REDRAW(mainListBox)
End if 

If (Form event code:C388=On Unload:K2:2)
	SET FIELD RELATION:C919([Registers:10]CustomerID:5; Manual:K51:3; Manual:K51:3)
End if 