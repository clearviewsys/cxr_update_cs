//%attributes = {}
//This method updates the old invoice book to the new one
// in the old database we didn't have the [invoices]currency field

ALL RECORDS:C47([Invoices:5])
READ WRITE:C146([Invoices:5])

While (Not:C34(End selection:C36([Invoices:5])))
	If ([Invoices:5]InvoiceID:1="14312")
		updateInvoiceRecordLine
	Else 
		updateInvoiceRecordLine
	End if 
	
	SAVE RECORD:C53([Invoices:5])
	NEXT RECORD:C51([Invoices:5])
End while 

UNLOAD RECORD:C212([Invoices:5])
READ ONLY:C145([Invoices:5])
myAlert("Update completed")