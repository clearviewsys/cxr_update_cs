//%attributes = {}
// selectAccountsPending
// this method select all accounts that are pending or receivable or payable

QUERY:C277([Accounts:9]; [Accounts:9]MainAccountID:2=c_Receivables; *)
QUERY:C277([Accounts:9];  | ; [Accounts:9]MainAccountID:2=c_Payables; *)
QUERY:C277([Accounts:9];  | ; [Accounts:9]isPendingAccount:24=True:C214)  // new addition in version 3.542