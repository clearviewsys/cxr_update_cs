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
	C_LONGINT:C283($page)
	$page:=FORM Get current page:C276
	Case of 
			
		: ($page=1)  // Risk Page
			// handleReviewAML_SummaryLB
			
			// find the first transaction date
			ORDER BY:C49([Registers:10]; [Registers:10]CreationDate:14; >)
			
			C_DATE:C307($firstDate; $lastDate)
			FIRST RECORD:C50([Registers:10])
			$firstDate:=[Registers:10]CreationDate:14
			LAST RECORD:C200([Registers:10])
			$lastDate:=[Registers:10]CreationDate:14
			
			OBJECT SET TITLE:C194(*; "firstTransactionDate"; String:C10($firstDate))
			OBJECT SET TITLE:C194(*; "lastTransactionDate"; String:C10($lastDate))
			
			relateMany(->[CallLogs:51]; ->[CallLogs:51]CustomerID:2; ->[Customers:3]CustomerID:1)  // notes
			
			
			// Modified by: Milan (3/26/2021) - there are AML Reports and reviews on page 1 also
			relateMany(->[AML_Reports:119]; ->[AML_Reports:119]CustomerID:19; ->[Customers:3]CustomerID:1)  // load AML_Reports
			orderByAML_Reports
			
			relateMany(->[KYC_ReviewLog:124]; ->[KYC_ReviewLog:124]CustomerID:2; ->[Customers:3]CustomerID:1)  // kyc review log
			relateMany(->[AML_ReviewLog:125]; ->[AML_ReviewLog:125]CustomerID:2; ->[Customers:3]CustomerID:1)  // aml risk log
			orderByKYC_ReviewLog
			orderByAML_ReviewLog
			
			SELECTION TO ARRAY:C260([KYC_ReviewLog:124]ReviewDate:3; arrDates_KYC)
			SELECTION TO ARRAY:C260([AML_ReviewLog:125]ReviewDate:3; arrDates_AML)
			
			
		: ($page=2)  // ID
			relateOne(->[CustomerTypes:94]; ->[Customers:3]GroupName:90; ->[CustomerTypes:94]CustomerTypeID:1)
			
		: ($page=3)  // Invoices & Registers
			relateMany(->[Invoices:5]; ->[Invoices:5]CustomerID:2; ->[Customers:3]CustomerID:1)  // invoices
			relateMany(->[Registers:10]; ->[Registers:10]CustomerID:5; ->[Customers:3]CustomerID:1)  // registers
			orderByInvoices
			orderByRegisters
			
		: ($page=4)  // CTR & Cheques
			relateMany(->[Cheques:1]; ->[Cheques:1]CustomerID:2; ->[Customers:3]CustomerID:1)  //cheques
			relateMany(->[CashTransactions:36]; ->[CashTransactions:36]CustomerID:10; ->[Customers:3]CustomerID:1)  // cash
			orderBycheques
			orderBycashTransactions
			
		: ($page=5)  // EFT - eWires & Wires
			relateMany(->[eWires:13]; ->[eWires:13]CustomerID:15; ->[Customers:3]CustomerID:1)  // ewires
			relateMany(->[Wires:8]; ->[Wires:8]CustomerID:2; ->[Customers:3]CustomerID:1)  // wire
			orderByeWires
			orderByWires
			
		: ($page=6)  // Links & Third Parties
			relateMany(->[Links:17]; ->[Links:17]CustomerID:14; ->[Customers:3]CustomerID:1)  // links
			relateMany(->[Invoices:5]; ->[Invoices:5]CustomerID:2; ->[Customers:3]CustomerID:1)  // invoices
			RELATE MANY SELECTION:C340([ThirdParties:101]InvoiceID:30)  // load related third parties; this must be called after relatemany invoices
			
		: ($page=7)  // KYC / AM Reviews
			relateMany(->[KYC_ReviewLog:124]; ->[KYC_ReviewLog:124]CustomerID:2; ->[Customers:3]CustomerID:1)  // kyc review log
			relateMany(->[AML_ReviewLog:125]; ->[AML_ReviewLog:125]CustomerID:2; ->[Customers:3]CustomerID:1)  // aml risk log
			orderByKYC_ReviewLog
			orderByAML_ReviewLog
			
		: ($page=8)  // Screening
			QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]InternalRecordID:2=[Customers:3]CustomerID:1; *)
			QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]internalTableID:12=Table:C252(->[Customers:3]))
			orderBySanctionCheckLog
			
		: ($page=9)  //AML Reports
			relateMany(->[AML_Reports:119]; ->[AML_Reports:119]CustomerID:19; ->[Customers:3]CustomerID:1)  // load AML_Reports
			orderByAML_Reports
			
		: ($page=10)
			relateMany(->[AML_Alerts:137]; ->[AML_Alerts:137]customerID:12; ->[Customers:3]CustomerID:1)  // load AML_alerts
			orderByAML_Alerts
	End case 
	
	SET TIMER:C645(0)  // reset timer
	
End if 

If (Form event code:C388=On Deactivate:K2:10)
	
End if 