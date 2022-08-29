//%attributes = {}
LOAD RECORD:C52([Registers:10])
RELATE ONE:C42([Registers:10]InvoiceNumber:10)
RELATE ONE:C42([Registers:10]CustomerID:5)
//setPrintOrientation (False)
setPrintSettingsForCheque
If (vPageSetup=0)
	printRecordUsingPrinter(->[Registers:10]; getClientChequeFormName; getClientChequePrinterName; getClientCopiesPerCheque)
Else 
	FORM SET OUTPUT:C54([Registers:10]; getClientChequeFormName)
	PRINT RECORD:C71([Registers:10])
End if 

