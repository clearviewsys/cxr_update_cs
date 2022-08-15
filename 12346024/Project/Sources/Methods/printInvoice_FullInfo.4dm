//%attributes = {}
// printInvoice_FullInfo (form)
// e.g. printInvoice_FullInfo ("printInvoice_FullInfo")

C_TEXT:C284($form; $1)
C_LONGINT:C283(vPageSetup)

// form: ([registers];"printInvoice_FullInfo")
// form: ([registers];"printInvoice_FullInfo_Internal")
Case of 
	: (Count parameters:C259=0)
		$form:=getKeyValue("printInvoice.FullPage"; "printInvoice_FullInfo")  // 
	: (Count parameters:C259=1)
		$form:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

setPrintSettingsDefault
SET PRINT PREVIEW:C364(<>previewBeforePrint)

If (vPageSetup=0)
	orderByRegisters
	setPrintSettings(getClientDefaultPrinterName; True:C214; getClientDefaultScale; getClientDefaultPageFormat)
	printSelectionUsingPrinter(->[Registers:10]; $form; getClientDefaultPrinterName; 0)
Else 
	printSelection(->[Registers:10]; $form)
End if 
