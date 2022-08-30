//%attributes = {}
C_REAL:C285(vRemainReceive; vRemainPaid; vOurExchangeRate; vExchangeRate)

checkIfNullString(->[Invoices:5]CustomerID:2; "Customer Code")
checkifRecordExists(->[Customers:3]; ->[Customers:3]CustomerID:1; ->[Invoices:5]CustomerID:2; "Customer "+[Invoices:5]CustomerID:2)
checkIfNullString(->[Invoices:5]fromCurrency:3; "'Customer Has' Field")
checkIfNullString(->[Invoices:5]toCurrency:8; "'Customer Wants' Field")
checkGreaterThan(->[Invoices:5]fromAmount:25; "From Amount"; 0; "warn")
checkGreaterThan(->[Invoices:5]toAmount:26; "To Amount"; 0; "warn")

If ((vRemainReceive#0) | (vRemainPaid#0))
	checkAddWarning("The transactions on this invoice are not balanced!")
End if 

If (isRateOffRange(vOurExchangeRate; vExchangeRate))
	checkAddWarning("The rate "+String:C10(vExchangeRate; "|rate")+" is very off from "+String:C10(vOurExchangeRate; "|rate"))
	
End if 

If ((vRemainReceive>0) & ([Customers:3]KYC_CreditRating:51=1))
	checkAddWarning([Customers:3]FullName:40+" has a poor credit rating. ")
End if 

validateInvoice_AMLRules

If ([Customers:3]isOnHold:52)
	checkAddWarning("This customer is on hold. "+[Customers:3]Comments:43)
End if 

