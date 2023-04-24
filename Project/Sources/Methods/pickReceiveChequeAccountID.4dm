//%attributes = {}
// pickReceiveChequeAccountID (object;Currency)

C_POINTER:C301($1)
C_TEXT:C284($2; vAccountCurrency)
vAccountCurrency:=$2
pickAccounts($1; "selectChequeDepositableAccounts")