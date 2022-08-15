//%attributes = {}
C_REAL:C285(vTotalAmount)
C_TEXT:C284(vCurrency; vFromCashAccount; vToCashAccount)
C_DATE:C307(vDate)

// validating between cash account transfers

checkIfValidDate(->vDate; "Date")
checkifRecordExists(->[Flags:19]; ->[Flags:19]CurrencyCode:1; ->vCurrency; "Currency")
checkifRecordExists(->[CashAccounts:34]; ->[CashAccounts:34]AccountID:1; ->vFromCashAccount; "From Cash Account")
checkifRecordExists(->[CashAccounts:34]; ->[CashAccounts:34]AccountID:1; ->vToCashAccount; "To Cash Account")
If (vFromCashAccount=vToCashAccount)
	checkAddError("You cannot transfer between the same cash accounts")
End if 
checkGreaterThan(->vTotalAmount; "Total transfer amount"; 0)

checkAddWarning("Please confirm transfer of "+String:C10(vTotalAmount; "|Currency")+" from "+vFromCashAccount+" to "+vToCashAccount)