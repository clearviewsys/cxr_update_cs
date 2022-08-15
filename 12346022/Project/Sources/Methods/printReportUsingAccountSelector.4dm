//%attributes = {}
// preinReportUsingAccountSelector (methodName)

C_TEXT:C284($method; $1)

Case of 
	: (Count parameters:C259=1)
		
		$method:=$1
		
	Else 
		$method:="acc_printFormAccountPositions"
		
End case 


C_LONGINT:C283(cb_AllAccs; cb_CashAccs; cb_BankAccs; cb_PendingAccs; cb_SettlementAccs; cb_TradingAccs; $OK)
C_TEXT:C284(vbranchID; vUserName)

openFormWindow(->[CompanyInfo:7]; "AccountsTypeSelector")

If (OK=1)
	
	Case of 
		: (Count parameters:C259=2)
			vFromDate:=Current date:C33
			vToDate:=Current date:C33
			$OK:=1
		Else 
			$OK:=requestDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; True:C214)
	End case 
	
	If (($OK=1) & (cb_AllAccs=1))  // if all accounts selected
		ALL RECORDS:C47([Accounts:9])
	End if 
	
	If (($OK=1) & (cb_AllAccs=0))  // if all accounts is NOT checked (THIS IS NOT THE ELSE STATEMENT OF THE ABOVE IF)
		
		QUERY:C277([Accounts:9]; [Accounts:9]Currency:6=""; *)  // start of the deferred queries
		
		If (cb_CashAccs=1)  // cash positions must be checked
			QUERY:C277([Accounts:9];  | ; [Accounts:9]isCashAccount:3=True:C214; *)
		End if 
		
		If (cb_BankAccs=1)  // bank positions
			QUERY:C277([Accounts:9];  | ; [Accounts:9]isBankAccount:7=True:C214; *)
		End if 
		
		If (cb_PendingAccs=1)  // pending accounts must be checked
			QUERY:C277([Accounts:9];  | ; [Accounts:9]isPendingAccount:24=True:C214; *)
		End if 
		
		If (cb_SettlementAccs=1)  // Settlement accounts must be checked
			QUERY:C277([Accounts:9];  | ; [Accounts:9]isSettlementAccount:25=True:C214; *)
		End if 
		
		If (cb_TradingAccs=1)  // Trading accounts must be checked
			QUERY:C277([Accounts:9];  | ; [Accounts:9]isInventory:18=True:C214; *)
		End if 
		
		QUERY:C277([Accounts:9];  | ; [Accounts:9]Currency:6="")  // this query is not doing anything special except for closing all the defferred queries
	End if 
	
	
	QUERY SELECTION:C341([Accounts:9]; [Accounts:9]isHidden:21=False:C215)  // filter out the hidden accounts first
	
	RELATE MANY SELECTION:C340([Registers:10]AccountID:6)  // maps all the selected accounts to their respective registers
	selectDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; nullDate; vToDate; True:C214)
	
	// all additional filters shall be here, such as filter by branch or by user ID
	// at this point all the related journal registers are selected
	If (vBranchID#"")  // query by branchID
		QUERY SELECTION:C341([Registers:10]; [Registers:10]BranchID:39=vBranchID)
	End if 
	
	If (vUserName#"")
		QUERY SELECTION:C341([Registers:10]; [Registers:10]CreatedByUserID:16=vUserName)
	End if 
	
	RELATE ONE SELECTION:C349([Registers:10]; [Accounts:9])  // map back all the registers into the accounts to filter out the accounts that were
	// not touched since the beginning
	orderByAccounts
	
	If (Records in selection:C76([Accounts:9])>0)  // THE PRINTING PROCESS
		printSettings
		If (OK=1)
			EXECUTE METHOD:C1007($method)
			
		End if 
		
	Else 
		myAlert("No matching records to print.")
	End if 
	
	
End if 
