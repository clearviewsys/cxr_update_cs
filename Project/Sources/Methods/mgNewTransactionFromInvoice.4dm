//%attributes = {}
// put this in object method to start MoneygramTransaction from Invoices entry form

C_TEXT:C284($1; $transactionType)

$transactionType:=$1

mgNewCustomerTransaction_OM($transactionType; [Invoices:5]CustomerID:2; New object:C1471("username"; "clerk"; "agentID"; "30015010"; "password"; "123123"))
