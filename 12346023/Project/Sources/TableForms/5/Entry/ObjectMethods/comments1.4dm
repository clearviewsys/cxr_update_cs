If ([Invoices:5]AMLReportingRef:47#"")
	[Invoices:5]isAMLReported:45:=True:C214
	[Invoices:5]AMLReportingDate:48:=Current date:C33
Else 
	[Invoices:5]isAMLReported:45:=False:C215
	[Invoices:5]AMLReportingDate:48:=!00-00-00!
End if 