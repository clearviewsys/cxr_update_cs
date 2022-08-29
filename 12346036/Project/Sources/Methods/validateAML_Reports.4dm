//%attributes = {}
checkIfNullString(->[AML_Reports:119]NameOfSubject:20; "Name of Subject")
If ([AML_Reports:119]isSuspiciousActivity:21)
	
End if 

Case of 
	: ([AML_Reports:119]Decision:18=0)  // not decided
		
	: ([AML_Reports:119]Decision:18=1)  // decided to report
		
	: ([AML_Reports:119]Decision:18=2)  // decided not to report
		checkIfNullString(->[AML_Reports:119]ReportNotes:16; "Decision Notes (Reason for not reporting")
		
	: ([AML_Reports:119]reportStatus:13=0)  // pending report
		
	: ([AML_Reports:119]reportStatus:13=1)  // reported
		checkifRecordExists(->[Invoices:5]; ->[Invoices:5]InvoiceID:1; ->[AML_Reports:119]invoiceID:2; "Invoice ID")
		checkIfNullString(->[AML_Reports:119]invoiceID:2; "Invoice ID")
		checkIfNullString(->[AML_Reports:119]TypeofReport:5; "Type of Report")
		checkIfNullString(->[AML_Reports:119]ReportedByUserID:7; "Reported By")
		checkIfNullString(->[AML_Reports:119]Reference:9; "Reference")
		
	: ([AML_Reports:119]reportStatus:13=2)  // rejected
		
	Else 
		
End case 