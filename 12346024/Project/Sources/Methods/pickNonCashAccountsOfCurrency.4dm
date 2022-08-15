//%attributes = {}
// pickNonCashAccountsOfCurrency (object;Currency)

C_POINTER:C301($1)
C_TEXT:C284($2; vAccountCurrency)
vAccountCurrency:=$2
setRequestString("Pick an account to send the wire from")
pickAccounts($1; "selectNonCashAccountsOfCurrency")