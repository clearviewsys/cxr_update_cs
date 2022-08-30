//HandleEntryForm (Current form table;->[Customers]CreatedByUserID;->[Customers]ModifiedByUserID;->[Customers]BranchID;->[Customers]modBranchID)

C_TEXT:C284($warn)

If (Form event code:C388=On Load:K2:1)
	
	If (isSLAExpired)
		myAlert("This feature is available with a valid SLA only.")
		CANCEL:C270
	End if 
	
	OBJECT SET TITLE:C194(*; "cb_signed"; "Signed & Approved By "+getApplicationUser)
	C_TEXT:C284(VDESCRIPTION)
	VDESCRIPTION:=""
	
	highlightMissingFieldsInCustKYC
	READ ONLY:C145([ThirdParties:101])
	If ([Customers:3]LastAMLReviewDate:123=!00-00-00!)
		$warn:="This is the first full AML Review for this Customer!"
	End if 
	
	OBJECT SET TITLE:C194(*; "l_warning"; $warn)
	handleCustomerRedFlagSigns
	SET TIMER:C645(-1)
	
End if 

If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
	highlightMissingFieldsInCustKYC
	handleCustomerRedFlagSigns
End if 

If (Form event code:C388=On Timer:K2:25)
	relateOne(->[CustomerTypes:94]; ->[Customers:3]GroupName:90; ->[CustomerTypes:94]CustomerTypeID:1)
	
	relateMany(->[KYC_ReviewLog:124]; ->[KYC_ReviewLog:124]CustomerID:2; ->[Customers:3]CustomerID:1)  // kyc review log
	relateMany(->[AML_ReviewLog:125]; ->[AML_ReviewLog:125]CustomerID:2; ->[Customers:3]CustomerID:1)  // aml risk log
	relateMany(->[AML_Reports:119]; ->[AML_Reports:119]CustomerID:19; ->[Customers:3]CustomerID:1)  // load AML_Reports
	relateMany(->[CallLogs:51]; ->[CallLogs:51]CustomerID:2; ->[Customers:3]CustomerID:1)  // notes
	relateMany(->[eWires:13]; ->[eWires:13]CustomerID:15; ->[Customers:3]CustomerID:1)  // ewires
	relateMany(->[Wires:8]; ->[Wires:8]CustomerID:2; ->[Customers:3]CustomerID:1)  // wire
	//relateMany (->[WireTemplates];->[WireTemplates]CustomerID;->[Customers]CustomerID)  // wire templates
	relateMany(->[Links:17]; ->[Links:17]CustomerID:14; ->[Customers:3]CustomerID:1)  // links
	
	relateMany(->[Cheques:1]; ->[Cheques:1]CustomerID:2; ->[Customers:3]CustomerID:1)  //cheques
	relateMany(->[CashTransactions:36]; ->[CashTransactions:36]CustomerID:10; ->[Customers:3]CustomerID:1)  // cash
	
	relateMany(->[Invoices:5]; ->[Invoices:5]CustomerID:2; ->[Customers:3]CustomerID:1)  // invoices
	RELATE MANY SELECTION:C340([ThirdParties:101]InvoiceID:30)  // load related third parties; this must be called after relatemany invoices
	
	// handleReviewAML_SummaryLB
	
	relateMany(->[Registers:10]; ->[Registers:10]CustomerID:5; ->[Customers:3]CustomerID:1)  // registers
	
	SELECTION TO ARRAY:C260([KYC_ReviewLog:124]ReviewDate:3; arrDates_KYC)
	SELECTION TO ARRAY:C260([AML_ReviewLog:125]ReviewDate:3; arrDates_AML)
	
	// find the first transaction date
	ORDER BY:C49([Registers:10]; [Registers:10]CreationDate:14; >)
	
	C_DATE:C307($firstDate; $lastDate)
	FIRST RECORD:C50([Registers:10])
	$firstDate:=[Registers:10]CreationDate:14
	LAST RECORD:C200([Registers:10])
	$lastDate:=[Registers:10]CreationDate:14
	
	OBJECT SET TITLE:C194(*; "firstTransactionDate"; String:C10($firstDate))
	OBJECT SET TITLE:C194(*; "lastTransactionDate"; String:C10($lastDate))
	
	orderByAML_Reports
	orderByKYC_ReviewLog
	orderByAML_ReviewLog
	
	SET TIMER:C645(0)  // reset timer
	
End if 

If (Form event code:C388=On Deactivate:K2:10)
	
End if 