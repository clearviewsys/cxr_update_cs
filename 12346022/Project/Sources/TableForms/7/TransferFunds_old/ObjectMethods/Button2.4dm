C_TEXT:C284(vFromAccount; vToAccount; vCurrency)

vFromAccount:=makeCashAccountID(vCurrency)
vToAccount:=makeBank(vCurrency)

C_REAL:C285($vAmount; vFromAmount)

vFromAmount:=Num:C11(Request:C163("Amount to deposit into bank?"; String:C10(vFromAmount; "|Currency")))