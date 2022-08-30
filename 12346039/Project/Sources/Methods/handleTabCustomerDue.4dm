//%attributes = {}
// handleTabCustomerRecPay( c_Receivables/c_Payables)

C_LONGINT:C283($pick; $1)
$pick:=$1

Case of 
		
	: ($pick=1)
		// first find all accounts that are receivale and payable
		QUERY:C277([Accounts:9]; [Accounts:9]MainAccountID:2=c_Receivables; *)
		QUERY:C277([Accounts:9];  | ; [Accounts:9]MainAccountID:2=c_Payables; *)
		QUERY:C277([Accounts:9];  | ; [Accounts:9]isPendingAccount:24=True:C214)
		
	: ($pick=2)
		// first find all accounts that are receivale
		QUERY:C277([Accounts:9]; [Accounts:9]MainAccountID:2=c_Receivables)
		
	: ($pick=3)
		// first find all accounts that are payable
		QUERY:C277([Accounts:9]; [Accounts:9]MainAccountID:2=c_Payables)
		
End case 

RELATE MANY SELECTION:C340([Registers:10]AccountID:6)
// filter this customer only (we need the receivables for this customer only)
QUERY SELECTION:C341([Registers:10]; [Registers:10]CustomerID:5=[Customers:3]CustomerID:1)
orderByRegisters
C_REAL:C285(vSumDebitsLocal; vSumCreditsLocal; vBalanceLocal)
getRegisterSums(->vSumDebitsLocal; ->vSumCreditsLocal; ->vBalanceLocal)
