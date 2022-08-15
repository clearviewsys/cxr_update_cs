handleViewFormMethod(Current form table:C627)

If (Form event code:C388=On Load:K2:1)
	READ ONLY:C145([Customers:3])
	READ ONLY:C145([Invoices:5])
	OBJECT SET ENABLED:C1123(*; "DecisionStatus"; False:C215)
	OBJECT SET ENABLED:C1123(*; "ReportStatus"; False:C215)
End if 