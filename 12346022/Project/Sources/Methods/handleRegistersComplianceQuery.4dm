//%attributes = {}
// handleRegistersComplianceQuery
// may be better to rename to : handleRegistersAuditQuery


declareAuditFormVariables

If (cbApplyDateRange=1)  // date range selection
	
	If (cbQuerySelection=1)  // within selection only (search on date range inside the selection
		QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate; *)
		QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
	Else   // search the date range only
		QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate; *)
		QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
	End if 
Else   // date range is not selection
	If (cbQuerySelection#1)  // query all records
		ALL RECORDS:C47([Registers:10])
	End if 
End if 


C_TEXT:C284($setName; $selectionSet; $emptySet)
$setName:="RegistersQuery"
$selectionSet:="RegistersSet"
$emptySet:="RegistersEmpty"

// FIRST DO THE FILTERS (EVERY register that has a special condition)

If (vCustomerID#"")
	QUERY SELECTION:C341([Registers:10]; [Registers:10]CustomerID:5=vCustomerID)
End if 

If (vRiskRating#0)  // to search by Risk Rating
	
	SET FIELD RELATION:C919([Registers:10]CustomerID:5; Automatic:K51:4; Manual:K51:3)
	QUERY SELECTION:C341([Registers:10]; [Customers:3]AML_RiskRating:75>=vRiskRating)  // only select registers that are related to customers that have a certain minimum risk rating
	//SET FIELD RELATION([Registers]CustomerID;Structure configuration;Structure configuration)  // @tiran added on Nov 16/2020 ; may affect reporting ? 
End if 

If (cbPEP#0)  // to search by PEP Determination
	SET FIELD RELATION:C919([Registers:10]CustomerID:5; Automatic:K51:4; Manual:K51:3)
	QUERY SELECTION:C341([Registers:10]; [Customers:3]AML_isPEP:80=cbPEP)  // only select registers that are related to customers that have a certain minimum risk rating
	//SET FIELD RELATION([Registers]CustomerID;Structure configuration;Structure configuration)  // @tiran added on Nov 16/2020 ; may affect reporting ? 
End if 

If (cbSuspicious#0)  // to search if Customer is Suspicious
	SET FIELD RELATION:C919([Registers:10]CustomerID:5; Automatic:K51:4; Manual:K51:3)
	If (cbSuspicious=1)
		QUERY SELECTION:C341([Registers:10]; [Customers:3]AML_isSuspicious:49=True:C214)  // only select registers that are related to customers that have a certain minimum risk rating
	Else 
		QUERY SELECTION:C341([Registers:10]; [Customers:3]AML_isSuspicious:49=False:C215)  // only select registers that are related to customers that have a certain minimum risk rating
	End if 
	//SET FIELD RELATION([Registers]CustomerID;Structure configuration;Structure configuration)  // @tiran added on Nov 16/2020 ; may affect reporting ? 
End if 

// filter certain accounts
If (vAccountID#"")
	QUERY SELECTION:C341([Registers:10]; [Registers:10]AccountID:6=vAccountID)  // 
End if 

// filter currency
If (vCurrency#"")
	QUERY SELECTION:C341([Registers:10]; [Registers:10]Currency:19=vCurrency)  // 
End if 

// filter branchID
If (vBranchID#"")
	QUERY SELECTION:C341([Registers:10]; [Registers:10]BranchID:39=vBranchID)
End if 

// IT IS ASSUMING THERE'S ONLY ONE BRANCH... IN A MULTI-BRANCH SITUATION IT WILL NOT PROPERLY DEDUCT ALL 
// BRANCHES SELF TRANSACTIONS
If (cbIncludeSelf=0)  // if include self-transaction is not checked then exclude all transactions done under self-
	QUERY SELECTION:C341([Registers:10]; [Registers:10]CustomerID:5#getSelfCustomerID)
	
	//SET AUTOMATIC RELATIONS(true)
	//QUERY SELECTION ([Registers];[Customers]isSelf=False)  // exclude self 
	//SET AUTOMATIC RELATIONS(false)
End if 


// exclude base currency
If (cbExcludeBaseCurrency=1)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]Currency:19#<>baseCurrency)
End if 


If (cbExcludeCompanies=1)
	SET AUTOMATIC RELATIONS:C310(True:C214)  // set automatic relations on for many to one
	QUERY SELECTION BY FORMULA:C207([Registers:10]; [Customers:3]isCompany:41=False:C215)
	SET AUTOMATIC RELATIONS:C310(False:C215)
End if 

If (cbExcludeMSBs=1)
	SET AUTOMATIC RELATIONS:C310(True:C214)  // set automatic relations on for many to one
	QUERY SELECTION BY FORMULA:C207([Registers:10]; [Customers:3]isMSB:85=False:C215)
	SET AUTOMATIC RELATIONS:C310(False:C215)
End if 

If (cbExcludeBanks=1)
	SET AUTOMATIC RELATIONS:C310(True:C214)  // set automatic relations on for many to one
	QUERY SELECTION BY FORMULA:C207([Registers:10]; [Customers:3]isWholesaler:87=False:C215)
	SET AUTOMATIC RELATIONS:C310(False:C215)
End if 

Case of 
		
	: ((cbIncludeDebit=0) & (cbIncludeCredit=1))
		If (vUpperRange>0)
			QUERY SELECTION:C341([Registers:10]; [Registers:10]CreditLocal:24>vLowerRange; *)
			QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]CreditLocal:24<=vUpperRange)
		Else 
			QUERY SELECTION:C341([Registers:10]; [Registers:10]CreditLocal:24>vLowerRange)
		End if 
		
	: ((cbIncludeDebit=1) & (cbIncludeCredit=0))
		
		If (vUpperRange>0)
			QUERY SELECTION:C341([Registers:10]; [Registers:10]DebitLocal:23>vLowerRange; *)
			QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]DebitLocal:23<=vUpperRange)
		Else 
			QUERY SELECTION:C341([Registers:10]; [Registers:10]DebitLocal:23>vLowerRange)
		End if 
		
	: ((cbIncludeDebit=1) & (cbIncludeCredit=1))
		
		If (vUpperRange>0)
			QUERY SELECTION:C341([Registers:10]; [Registers:10]CreditLocal:24>vLowerRange; *)
			QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]CreditLocal:24<=vUpperRange; *)
			QUERY SELECTION:C341([Registers:10];  | ; [Registers:10]DebitLocal:23>vLowerRange; *)
			QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]DebitLocal:23<=vUpperRange)
			
		Else 
			QUERY SELECTION:C341([Registers:10]; [Registers:10]CreditLocal:24>vLowerRange; *)
			QUERY SELECTION:C341([Registers:10];  | ; [Registers:10]DebitLocal:23>vLowerRange)
		End if 
	: ((cbIncludeDebit=0) & (cbIncludeCredit=0))
End case 


CREATE SET:C116([Registers:10]; $selectionSet)
CREATE EMPTY SET:C140([Registers:10]; $emptySet)

If (cbIncludeCash=1)  // include all cash accounts
	USE SET:C118($selectionSet)  // load the selection
	QUERY SELECTION:C341([Registers:10]; [Registers:10]InternalTableNumber:17=Table:C252(->[CashTransactions:36]))
	CREATE SET:C116([Registers:10]; $setName)
	UNION:C120($emptySet; $setName; $emptySet)  // add to the emptySet
End if 

If (cbIncludeWires=1)  // include all wire accounts
	USE SET:C118($selectionSet)  // load the selection
	QUERY SELECTION:C341([Registers:10]; [Registers:10]InternalTableNumber:17=Table:C252(->[Wires:8]))
	CREATE SET:C116([Registers:10]; $setName)
	UNION:C120($emptySet; $setName; $emptySet)  // add to the emptySet
End if 

If (cbIncludeeWires=1)  // include all eWires
	USE SET:C118($selectionSet)  // load the selection
	QUERY SELECTION:C341([Registers:10]; [Registers:10]InternalTableNumber:17=Table:C252(->[eWires:13]))
	CREATE SET:C116([Registers:10]; $setName)
	UNION:C120($emptySet; $setName; $emptySet)  // add to the emptySet
End if 

If (cbIncludeCheques=1)  // include all Cheques
	USE SET:C118($selectionSet)  // load the selection
	QUERY SELECTION:C341([Registers:10]; [Registers:10]InternalTableNumber:17=Table:C252(->[Cheques:1]))
	CREATE SET:C116([Registers:10]; $setName)
	UNION:C120($emptySet; $setName; $emptySet)  // add to the emptySet
End if 


If (cbIncludeAccounts=1)  // include all accounts in and outs
	USE SET:C118($selectionSet)  // load the selection
	QUERY SELECTION:C341([Registers:10]; [Registers:10]InternalTableNumber:17=Table:C252(->[AccountInOuts:37]))
	CREATE SET:C116([Registers:10]; $setName)
	UNION:C120($emptySet; $setName; $emptySet)  // add to the emptySet
End if 

If (cbIncludeItems=1)  // include all Items
	USE SET:C118($selectionSet)  // load the selection
	QUERY SELECTION:C341([Registers:10]; [Registers:10]InternalTableNumber:17=Table:C252(->[ItemInOuts:40]))
	CREATE SET:C116([Registers:10]; $setName)
	UNION:C120($emptySet; $setName; $emptySet)  // add to the emptySet
End if 



USE SET:C118($emptySet)



CLEAR SET:C117($setName)
CLEAR SET:C117($emptySet)
CLEAR SET:C117($selectionSet)



REDRAW WINDOW:C456(vRegisterWindowRef)



