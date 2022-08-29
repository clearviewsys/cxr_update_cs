

Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(arrInvoiceFormats; 0)
		C_TEXT:C284(vInvoiceFormat)
		vInvoiceFormat:=""
		arrInvoiceFormats:=0
		LIST TO ARRAY:C288("invoicePrintForms"; arrInvoiceFormats)
		
		//If (◊lastInvoiceFormat#"")
		arrInvoiceFormats:=Find in array:C230(arrInvoiceFormats; <>lastInvoiceFormat)
		//End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		vInvoiceFormat:=arrInvoiceFormats{arrInvoiceFormats}
		<>lastInvoiceFormat:=vInvoiceFormat
	Else 
		
End case 