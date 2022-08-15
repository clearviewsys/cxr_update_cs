//%attributes = {}
// createeWireAccounts(currency)

C_TEXT:C284($1; $currency)
$currency:=$1

createAccount(makeeWirePayable($Currency); "Payables"; $1; True:C214; False:C215)
createAccount(makeeWireReceivable($Currency); "Receivables"; $1; True:C214; False:C215)

