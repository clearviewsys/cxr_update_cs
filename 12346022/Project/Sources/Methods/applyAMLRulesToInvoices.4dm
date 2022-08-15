//%attributes = {}
// applyAMLRulesToInvoices (dateRange)

C_LONGINT:C283($progress)
C_LONGINT:C283($i; $n)
C_POINTER:C301($tablePtr)
C_OBJECT:C1216($dateRange)

Case of 
	: (Count parameters:C259=0)
		C_DATE:C307($fromDate; $toDate)
		$toDate:=Current date:C33
		$fromDate:=newDate(1; 1; 2020)
		$dateRange:=newDateRange($fromDate; $toDate; True:C214)
	: (Count parameters:C259=1)
		$dateRange:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

READ ONLY:C145([Customers:3])
READ ONLY:C145([Invoices:5])

If ($dateRange.applyDateRange=True:C214)
	QUERY:C277([Invoices:5]; [Invoices:5]invoiceDate:44>=$dateRange.fromDate; *)
	QUERY:C277([Invoices:5];  & ; [Invoices:5]invoiceDate:44<=$dateRange.toDate)
Else 
	ALL RECORDS:C47([Invoices:5])
End if 

If (Records in selection:C76([Invoices:5])>0)
	runAMLRulesOnInvoiceSelection
Else 
	myAlert("No Invoices found in the date range!")
End if 