//%attributes = {}
READ ONLY:C145([Invoices:5])
QUERY:C277([Invoices:5]; [Invoices:5]CreatedByUserID:19=getApplicationUser; *)
QUERY:C277([Invoices:5];  & ; [Invoices:5]invoiceDate:44=Current date:C33)
orderByInvoices

