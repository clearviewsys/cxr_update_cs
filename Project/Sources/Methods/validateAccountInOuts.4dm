//%attributes = {}
checkIfNullString(->[AccountInOuts:37]AccountInOutID:1; "Account In Out ID")
checkUniqueKey(->[AccountInOuts:37]; ->[AccountInOuts:37]AccountInOutID:1; "Trans ID")
//checkIfNullString(->[AccountInOuts]AccountInOut ID;"AccountInOut ID")
checkGreaterThan(->[AccountInOuts:37]Amount:7; "Amount"; 0)
RELATE ONE:C42([AccountInOuts:37]AccountID:6)

If ([Accounts:9]doWarnOnDebit:22)  // receive
	checkAddWarningOnTrue(([AccountInOuts:37]isPaid:9=False:C215); [Accounts:9]AccountID:1+" should normally pay, not received money.")
End if 

If ([Accounts:9]doWarnOnCredit:23)
	checkAddWarningOnTrue(([AccountInOuts:37]isPaid:9=True:C214); [Accounts:9]AccountID:1+" should normally receive money into, not pay out money.")
	
End if 


checkifStringsEqual(->[AccountInOuts:37]Currency:8; "Currency"; [Accounts:9]Currency:6)

checkIfAccountIDExists(->[AccountInOuts:37]AccountID:6; "Account Name (ID)")

checkifRecordExists(->[Customers:3]; ->[Customers:3]CustomerID:1; ->[AccountInOuts:37]CustomerID:2; "Customer ID")
checkIfValidDate(->[AccountInOuts:37]Date:3; "Date")
//checkifRecordExists (->[Flags];->[Flags]CurrencyCode;->[AccountInOuts]Currency;"Currency")

