C_LONGINT:C283(vPageSetup)
If (doComplyWithSkatteverket)
	// Replaced on: 2/8/2017 - BY: CVS Dev. Team
	// myAlert ("This feature is disabled due to Skatteverket compliance.")
	myAlert(GetLocalizedErrorMessage(4090))
Else 
	setPrintSettingsDefault
	
	pageSetupInvoice
	If (OK=1)
		SET PRINT PREVIEW:C364(<>previewBeforePrint)
		
		setPrintSettings(<>lastPrinterName; True:C214; 100; <>lastPageOption)
		printSelectionUsingPrinter(->[Registers:10]; <>lastInvoiceFormat; <>lastPrinterName; 0)
	End if 
End if 