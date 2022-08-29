openFormWindow(->[Invoices:5]; "ReceiveeWire")
//handlePaymentInInvoiceForTable (->[eWires];->[eWires]OurInvoiceNumber;->[eWires]isPaymentSent;True;True)
//RELATE MANY([Invoices]InvoiceNumber)  ` load the registers linked
//QUERY([Registers];[Registers]InvoiceNumber=vInvoiceNumber)
relateManyRegistersForInvoice