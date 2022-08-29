//%attributes = {}
// getCustomerBalanceDue(customerID; ->vSumDebit;->vSumCredit;->vBalance) 
// this method returns the balance due by the customer
// if the balance is positive the customer ows us, otherwise we owe to the customer

C_TEXT:C284($1; $vCustomerID)
C_POINTER:C301($2; $3; $4)

$vCustomerID:=$1

QUERY:C277([Accounts:9]; [Accounts:9]MainAccountID:2=c_Receivables; *)
QUERY:C277([Accounts:9];  | ; [Accounts:9]MainAccountID:2=c_Payables; *)
QUERY:C277([Accounts:9];  | ; [Accounts:9]isPendingAccount:24=True:C214)

RELATE MANY SELECTION:C340([Registers:10]AccountID:6)

// filter this customer only (we need the receivables for this customer only)
QUERY SELECTION:C341([Registers:10]; [Registers:10]CustomerID:5=$vCustomerID)

getRegisterSums($2; $3; $4)
