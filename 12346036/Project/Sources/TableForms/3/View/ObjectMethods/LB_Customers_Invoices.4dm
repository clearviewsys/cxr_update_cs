//handleListBoxObjectMethod (Self;->[Invoices])
C_LONGINT:C283($row)
C_TEXT:C284($rowSelection)

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Selection Change:K2:29))
	loadRelatedRegisters(->[Invoices:5]; ->[Registers:10]InvoiceNumber:10)
End if 

If (Form event code:C388=On Double Clicked:K2:5)
	handledoubleclickevent(->[Invoices:5])
End if 



