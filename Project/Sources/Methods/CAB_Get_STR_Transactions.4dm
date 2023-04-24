//%attributes = {}
// CAB_Get_STR_Transactions

Case of 
	: (Count parameters:C259=0)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


// Define transaction arrays

READ ONLY:C145([Registers:10])
READ ONLY:C145([Invoices:5])

QUERY:C277([Invoices:5]; [Invoices:5]invoiceDate:44>=vFromDate; *)
QUERY:C277([Invoices:5];  & ; [Invoices:5]invoiceDate:44<=vToDate; *)
QUERY:C277([Invoices:5];  & ; [Invoices:5]isSuspicious:30=True:C214)

orderByInvoices

RELATE MANY SELECTION:C340([Registers:10]InvoiceNumber:10)  // load all registers related to selected invoices
orderByRegisters









