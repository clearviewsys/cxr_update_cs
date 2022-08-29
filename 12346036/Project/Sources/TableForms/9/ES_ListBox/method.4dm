
//displayGrid_Accounts
//This_getAccountOpening
//This_getAccountSumOfTransfers

//This_getAccountSumOfBuys
//This_getAccountSumOfSells
//This_getAccountBalance
//[Accounts]AgentID
//[Accounts]accounttype
If (Form event code:C388=On Load:K2:1)
	READ ONLY:C145([Accounts:9])
	SET TIMER:C645(5)
	Form:C1466.searchString:=""
	Form:C1466.hideInactives:=0
End if 

If (Form event code:C388=On Timer:K2:25)
	SET TIMER:C645(0)
	
	
	C_POINTER:C301($mainAccountPtr; $accountTypePtr; $agentPtr; $tillPtr; $ccyPtr; $branchPtr)
	C_TEXT:C284($mainAccountID; $branchID; $accountType; $till; $CCY; $agentID)
	
	$mainAccountPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "dd_mainAccountID")
	$accountTypePtr:=OBJECT Get pointer:C1124(Object named:K67:5; "dd_accountType")
	$agentPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "dd_Agent")
	$tillPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "dd_Till")
	$ccyPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "dd_CCY")
	$branchPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "dd_branch")
	
	$mainAccountID:=$mainAccountPtr->{$mainAccountPtr->}
	$accountType:=$accountTypePtr->{$accountTypePtr->}
	$agentID:=$agentPtr->{$agentPtr->}
	$till:=$tillPtr->{$tillPtr->}
	$CCY:=$ccyPtr->{$ccyPtr->}
	$branchID:=$branchPtr->{$branchPtr->}
	
	
	If ($till#"")  // this has to be done before any other query selection is done; because otherwise, we affect the selection in [accounts] table
		READ ONLY:C145([CashAccounts:34])
		QUERY:C277([CashAccounts:34]; [CashAccounts:34]CashRegisterID:2=$till)  // first find the cash accounts related to teh selected till
		RELATE ONE SELECTION:C349([CashAccounts:34]; [Accounts:9])  // this has to happen before all the other 
	Else 
		ALL RECORDS:C47([Accounts:9])
	End if 
	
	
	querySelectionByTriStateCB(->[Accounts:9]isCashAccount:3; Form:C1466.filterCash; 1; True:C214)
	querySelectionByTriStateCB(->[Accounts:9]isBankAccount:7; Form:C1466.filterBank; 1; True:C214)
	querySelectionByTriStateCB(->[Accounts:9]isEFT:41; Form:C1466.filterEFT; 1; True:C214)
	querySelectionByTriStateCB(->[Accounts:9]isPendingAccount:24; Form:C1466.filterPending; 1; True:C214)
	querySelectionByTriStateCB(->[Accounts:9]isForeignAccount:15; Form:C1466.filterAgent; 1; True:C214)
	querySelectionByTriStateCB(->[Accounts:9]isSettlementAccount:25; Form:C1466.filterSettlement; 1; True:C214)
	querySelectionByTriStateCB(->[Accounts:9]isInventory:18; Form:C1466.filterTrade; 1; True:C214)
	querySelectionByTriStateCB(->[Accounts:9]isForeignAccount:15; Form:C1466.filterForeignAccount; 1; False:C215)
	
	If (Form:C1466.searchString#"")
		QUERY SELECTION:C341([Accounts:9]; [Accounts:9]AccountID:1="@"+Form:C1466.searchString+"@")
	End if 
	
	
	If ($mainAccountPtr->>1)  // not the first selection
		QUERY SELECTION:C341([Accounts:9]; [Accounts:9]MainAccountID:2=$mainAccountID)
	End if 
	
	If ($agentPtr->>1)
		QUERY SELECTION:C341([Accounts:9]; [Accounts:9]AgentID:16=$agentID)
	End if 
	
	If ($accountTypePtr->>1)
		QUERY SELECTION:C341([Accounts:9]; [Accounts:9]AccountType:5=$accountType)
	End if 
	
	If ($ccyPtr->>1)
		QUERY SELECTION:C341([Accounts:9]; [Accounts:9]Currency:6=$CCY)
	End if 
	
	If (Form:C1466.hideInactives=1)
		//map the accounts to the registers
		RELATE MANY SELECTION:C340([Registers:10]AccountID:6)  // load the registers
		RELATE ONE SELECTION:C349([Registers:10]; [Accounts:9])
	End if 
	
	orderByAccounts
	Form:C1466.ListBox:=Create entity selection:C1512([Accounts:9])
	
End if 

// formula: getAccountBalance (This.AccountID;vFromDate;vtoDate;numToBoolean (Form.applyDates))