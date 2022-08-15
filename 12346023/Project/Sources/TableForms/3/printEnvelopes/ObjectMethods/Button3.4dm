setPrintPaperName(getClientDefaultPrinterName)
setPrintOrientation(False:C215)
setPrintPaperName("#10 Envelope")
printSettings
If (OK=1)
	FORM SET OUTPUT:C54([Customers:3]; "printEnvelope")
	PRINT RECORD:C71([Customers:3]; *)
End if 