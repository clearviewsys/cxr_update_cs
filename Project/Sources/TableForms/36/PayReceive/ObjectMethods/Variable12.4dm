
// I added this line because vCurrency didn't get updated when we changed a line and sometimes allowed the user to pick the wrong account (say Cash-CAD when the currency is USD)
vCurrency:=[Currencies:6]ISO4217:31  // added on version 3.595 


pickAccounts(Self:C308; "selectAccountsForCashTrans")
C_POINTER:C301($subAccountPtr)
