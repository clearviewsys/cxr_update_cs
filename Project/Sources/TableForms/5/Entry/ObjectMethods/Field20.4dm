If ((Form event code:C388=On Clicked:K2:4) & ([Invoices:5]isAMLReported:45=True:C214))
	GOTO OBJECT:C206([Invoices:5]AMLReportingRef:47)
	[Invoices:5]AMLReportingDate:48:=Current date:C33
End if 