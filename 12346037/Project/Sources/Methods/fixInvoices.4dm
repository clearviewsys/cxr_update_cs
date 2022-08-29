//%attributes = {}
If (isUserAdministrator)
	
	C_DATE:C307(vfromdate; vToDate)
	requestDateRange
	If (OK=1)
		selectDateRangeTable(->[Invoices:5]; ->[Invoices:5]invoiceDate:44; vFromDate; vToDate; False:C215)
		
		If (Records in selection:C76([Invoices:5])>0)
			updateTableUsingMethod(->[Invoices:5]; "fixInvoiceRow"; True:C214)
		Else 
			myAlert("No invoices fixed.")
		End if 
		
	End if 
End if 
