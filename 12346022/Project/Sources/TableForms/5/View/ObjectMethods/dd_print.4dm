C_LONGINT:C283($selection)
If (Form event code:C388=On Clicked:K2:4)
	$selection:=Self:C308->
	
	Case of 
		: ($selection=1)  // tabular style
			printInvoiceUsingForm_v17("print_Tabular")
			
		: ($selection=2)  // large
			printInvoiceUsingForm_v17("print_Large")
			
		: ($selection=3)  // medium 
			printInvoiceUsingForm_v17("print_Medium")
			
		: ($selection=4)  // thermal
			printInvoiceUsingForm_v17("print_Thermal")
			
	End case 
	
End if 