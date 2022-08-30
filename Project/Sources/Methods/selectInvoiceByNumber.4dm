//%attributes = {}
// selectInvoiceByNumber(InvoiceNumber:text)
// POST: makes the invoice table read only

C_TEXT:C284($invoiceNumber; $1)
$invoiceNumber:=$1

READ ONLY:C145([Invoices:5])
QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=$invoiceNumber)

