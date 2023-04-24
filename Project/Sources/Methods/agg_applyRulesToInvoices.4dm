//%attributes = {}
// agg_applyRuleToInvoices (dateRange: object ; omitDialog:bool)
// formerly called: applyAMLRulesToInvoices (dateRange;omitDialog)
// runs the AML Aggr Rules on a date range of invoices
// this method runs classic 4D Queries on the Invoices to select the date range
// POST: selection of invoices will be affected


C_OBJECT:C1216($1; $dateRange)
C_BOOLEAN:C305($omitDialog; $2)

$omitDialog:=False:C215

C_LONGINT:C283($progress; $i; $n)
C_POINTER:C301($tablePtr)
C_DATE:C307($fromDate; $toDate)

Case of 
		
	: (Count parameters:C259=0)
		$toDate:=Current date:C33
		$fromDate:=newDate(1; 1; 2020)
		$dateRange:=newDateRange($fromDate; $toDate; True:C214)
		
	: (Count parameters:C259=1)
		$dateRange:=$1
		
	: (Count parameters:C259=2)
		$dateRange:=$1
		$omitDialog:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

READ ONLY:C145([Customers:3])
READ ONLY:C145([Invoices:5])

Case of 
	: ($dateRange.applyDateRange=True:C214)
		QUERY:C277([Invoices:5]; [Invoices:5]invoiceDate:44>=$dateRange.fromDate; *)
		QUERY:C277([Invoices:5];  & ; [Invoices:5]invoiceDate:44<=$dateRange.toDate)
	: (Records in selection:C76([Invoices:5])>0)  // just use the selection - @ibb 11/29/22
		// $dateRange.applyDateRange=False
	Else 
		ALL RECORDS:C47([Invoices:5])
End case 

If (Records in selection:C76([Invoices:5])>0)
	CAB_log("RULES: Start processing "+String:C10(Records in selection:C76([Invoices:5]))+" invoices.")
	agg_runRulesOnInvoices
	CAB_log("RULES: Completed.")
Else 
	If (Not:C34($omitDialog))
		myAlert("No Invoices found in the date range!")
	End if 
End if 