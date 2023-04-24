C_TEXT:C284(vFromAccount; vToAccount; vCurrency)

vToAccount:=makeCashAccountID(vCurrency)
vFromAccount:=makeBank(vCurrency)

C_REAL:C285($vAmount; vFromAmount)

vFromAmount:=Num:C11(Request:C163("Amount to withdraw from bank?"; String:C10(vFromAmount; "|Currency")))