//%attributes = {}

If (True:C214)
	showDateRangeTable(->[Registers:10]; ->[Invoices:5]invoiceDate:44)
Else 
	showDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2)
End if 