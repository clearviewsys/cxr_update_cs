If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Load:K2:1))
	C_LONGINT:C283($page)
	$page:=Self:C308->
	
	Case of 
			
		: ($page=1)  // invoices
			//READ ONLY([Invoices])
			//QUERY([Invoices];[Invoices]CustomerID=[Customers]CustomerID)
			//orderByInvoices 
			
			// [Invoices];"ListBox"
			//OBJECT SET SUBFORM(*;"SubForm";[LinkedDocs];"View";"Subform_CompanyInfo")
			
		: ($page=2)  // invoices
			READ ONLY:C145([Invoices:5])
			QUERY:C277([Invoices:5]; [Invoices:5]CustomerID:2=[Customers:3]CustomerID:1)
			orderByInvoices
			
			// [Invoices];"ListBox"
			OBJECT SET SUBFORM:C1138(*; "SubForm"; [Invoices:5]; "View"; "ListBox")
	End case 
End if 
