//%attributes = {}
C_REAL:C285(vRemainReceive; vRemainPaid; vOurExchangeRate; vExchangeRate)

checkUniqueKey(->[Invoices:5]; ->[Invoices:5]InvoiceID:1; "Invoice No")

checkIfNullString(->[Invoices:5]CustomerID:2; "Customer ID")
checkIfValidDate(->[Invoices:5]invoiceDate:44; "Invoice Date")
checkAddErrorIf([Invoices:5]isCancelled:84; "This is invoice is Cancelled")


checkifRecordExists(->[Customers:3]; ->[Customers:3]CustomerID:1; ->[Invoices:5]CustomerID:2; "Customer "+[Invoices:5]CustomerID:2)
If ((vSumDebitsLocal=0) & (vSumCreditsLocal=0))
	If (Records in selection:C76([Registers:10])=0)
		checkAddErrorIf([Invoices:5]printRemarks:16=""; "Please enter reason why there are no lines in this invoice (Why is it blank?)")
	End if 
End if 

If ((vDueFromCustomer#0) | (vDueToCustomer#0))
	checkAddError("Invoice must be balanced before Saving!")
End if 

If ((vRemainReceive#0) | (vRemainPaid#0))
	checkAddWarning("The transactions on this invoice are not balanced!")
End if 

//If ((vRemainReceive>0) & ([Customers]rating=1))
//checkAddWarning ([Customers]FullName+" has a poor credit rating. ")
//End if

If ([Invoices:5]isTransfer:42)
	checkAddErrorIf((vFromAmount#vToAmount); "Transfer amounts do not balance out!")
End if 

If (vCustomerID#getSelfCustomerID)  //   get to this later... it seems to have a problem
	validateInvoice_AMLRules
End if 

If ([Customers:3]isOnHold:52)
	checkAddError("This customer is on hold. "+[Customers:3]AML_OnHoldNotes:127+CRLF+[Customers:3]Comments:43)
End if 


If (Record number:C243([Invoices:5])>0)  // modification
	If ([Invoices:5]CustomerID:2#Old:C35([Invoices:5]CustomerID:2))
		checkAddErrorIf(doComplyWithSkatteverket; "Cannot make modifications to invoice due to compliance with Skatteverket.")
		checkAddWarning("Are you sure you want to change customer ID of this invoice from "+Old:C35([Invoices:5]CustomerID:2)+" to "+[Invoices:5]CustomerID:2)
		checkAddWarning("You may need to use the Integrity -> fix registers to reassign customer IDs")
	End if 
	If ([Invoices:5]invoiceDate:44#Old:C35([Invoices:5]invoiceDate:44))
		checkAddWarning("Original date of invoice has been modified from "+String:C10(Old:C35([Invoices:5]invoiceDate:44))+" to "+String:C10([Invoices:5]invoiceDate:44))
		checkAddWarning("You may need to use 'Fix Registers' from the Integrity menu, to reassign the date"+"s of the registers to the new invoice date.")
		
	End if 
End if 

If (Not:C34(checkErrorExist))
	validateSkatteverketInInvoice
End if 
// getKeyValueDescription
If (getKeyValue("Invoice.TransactionCode.Required"; "true")="true")
	checkAddErrorIf((<>ISTRANSACTIONCODEVISIBLE & ([Invoices:5]TransactionTypeID:91="")); "Transaction Type is manadatory")
End if 

If (getKeyValue("Invoice.CustomerType.Required"; "true")="true")
	checkAddErrorIf((<>ISCUSTOMERCODEVISIBLE & ([Invoices:5]CustomerTypeID:92="")); "Customer Code cannot be left blank")
End if 

// New AML Rule Validation before saving
agg_validateLicense