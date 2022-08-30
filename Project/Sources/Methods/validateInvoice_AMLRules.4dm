//%attributes = {}
// validateInvoice_AMLRules
// This validation is for the Invoices.entry page 

C_REAL:C285(vFromAmount; vFromMarketAvg; vAmountLocal)
C_REAL:C285(vSumDebitsLocal; vSumCreditsLocal; <>twoIDsLimit; <>declarationFormLimit)

If (<>doFINTRACchecks)  // FINTRAC compliancy checks
	
	If (Not:C34([Customers:3]isCompany:41))  // checks to be performed for people
		If (([Invoices:5]CustomerID:2#getSelfCustomerID) & (vAmountLocal>=<>oneIDLimit) & (vecPaymentMethod{vecPaymentMethod}=c_Cash) & (countCustomerPictureIDs([Invoices:5]CustomerID:2)=0))
			checkAddWarning([Customers:3]FullName:40+" does not have a valid picture ID on file. (KYC requirement)")
			checkAddWarningOnTrue(([Invoices:5]isAMLReportable:46=False:C215); "This transaction needs to be checked as 'Must Report'")
		End if 
		If ([Invoices:5]CustomerID:2#getWalkInCustomerID)
			validateCustomerKYC
		End if 
	Else 
		If ([Invoices:5]CustomerID:2#getSelfCustomerID)
			validateCompanyKYC
		End if 
		
	End if 
	
	
	
	If (([Invoices:5]CustomerID:2#getSelfCustomerID) & (vSumDebitsLocal>=<>twoIDsLimit))
		//checkAddWarning ("This transaction may need to be declared.")
		checkAddWarningOnTrue(([Invoices:5]isAMLReportable:46=False:C215); "This transaction may need to be marked as 'Must Report'")
	End if 
	
	If (([Invoices:5]CustomerID:2#getSelfCustomerID) & (vSumDebitsLocal>=<>declarationFormLimit))
		checkAddWarningOnTrue(([Invoices:5]isAMLReportable:46=False:C215); "This transaction needs to be checked as 'Must Report'")
		checkAddWarning("This transaction may require addition information to be asked from the customer. ")
		
	End if 
	
	
	If (([Invoices:5]isSuspicious:30) & (Length:C16([Invoices:5]suspiciousNotes:31)<20))
		checkIfNullString(->[Invoices:5]suspiciousNotes:31; "Details about the suspicious transaction")
		checkAddWarning("Details of the suspicous transaction is too short.")
		checkAddWarningOnTrue(([Invoices:5]isAMLReportable:46=False:C215); "Suspicious transactions need to be checked as 'Must Report'")
		
	End if 
	
	
	If (([Invoices:5]suspiciousNotes:31#"") & (Not:C34([Invoices:5]isSuspicious:30)))
		checkAddWarning("You entered notes in the 'suspicious notes' but you haven't marked t"+"his transaction as 'suspicious'.")
	End if 
	
	If ([Customers:3]AML_isSuspicious:49)
		checkAddWarning("This customer is marked as suspicious in the customers database !")
		If (Not:C34([Invoices:5]isSuspicious:30))
			checkAddWarning("Customer is suspicious therefore this transaction should be marked as susp"+"icious too.")
		End if 
	End if 
	// Additional FINTRAC Validation added  by Jaime Alvarez on 06/09/2017
	// If third party (individual or company) is involved in the Invoice, We need to ask for more information
	
	If ([Invoices:5]ThirdPartyisInvolved:22)
		validateThirdParties
	End if 
	
End if 


// FT_ValidateCustomerInfo 

