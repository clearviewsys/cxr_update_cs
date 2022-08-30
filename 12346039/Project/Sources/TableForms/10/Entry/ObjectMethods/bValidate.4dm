checkInit
validateRegisters


If (isValidationConfirmed)
	If ([Registers:10]InvoiceNumber:10="")
		[Registers:10]InvoiceNumber:10:="000"
	End if 
Else 
	REJECT:C38
End if 

