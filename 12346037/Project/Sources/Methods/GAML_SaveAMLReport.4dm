//%attributes = {}
// GAML_SaveAMLReport
// Create a new entry on table AMLReports

C_TEXT:C284($1; $reportType)

Case of 
	: (Count parameters:C259=1)
		$reportType:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


READ WRITE:C146([AML_Reports:119])
CREATE RECORD:C68([AML_Reports:119])

[AML_Reports:119]AML_ReportID:14:=""
[AML_Reports:119]BranchID:15:=getBranchID
[AML_Reports:119]CustomerID:19:=[Customers:3]CustomerID:1
[AML_Reports:119]Decision:18:=0

[AML_Reports:119]DecisionDate:17:=!00-00-00!
[AML_Reports:119]DiscoveredByUserID:4:=""
[AML_Reports:119]DiscoveryDate:3:=!00-00-00!
[AML_Reports:119]DiscoveryNotes:8:=""

[AML_Reports:119]invoiceID:2:=[Invoices:5]InvoiceID:1
[AML_Reports:119]isFlagged:10:=False:C215
[AML_Reports:119]isSuspiciousActivity:21:=True:C214
[AML_Reports:119]NameOfSubject:20:=[Customers:3]FullName:40

[AML_Reports:119]Reference:9:=AML_EntityReference
[AML_Reports:119]ReportDate:6:=Current date:C33(*)
[AML_Reports:119]ReportedByUserID:7:=getApplicationUser
[AML_Reports:119]ReportNotes:16:=""
[AML_Reports:119]reportStatus:13:=2  // Not Filled
[AML_Reports:119]TypeofReport:5:=$reportType

SAVE RECORD:C53([AML_Reports:119])

READ ONLY:C145([AML_Reports:119])
REDUCE SELECTION:C351([AML_Reports:119]; 0)
