If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(arrReceiptList; 0)
	LIST TO ARRAY:C288("InvoicePrintForms"; arrReceiptList)
	arrReceiptList:=1
End if 