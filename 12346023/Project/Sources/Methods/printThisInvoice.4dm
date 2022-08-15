//%attributes = {}
// printThisInvoice (copy:bool)

C_BOOLEAN:C305($1; $isCopy)
C_TEXT:C284(printNote)

Case of 
	: (Count parameters:C259=1)
		$isCopy:=$1
		printNote:="COPY"
	Else 
		$isCopy:=False:C215
		printNote:=""
End case 


orderByRegisters
setPrintSettingsForReceipt
printSelectionUsingPrinter(->[Registers:10]; getClientInvoiceFormName; getClientReceiptPrinterName; getClientCopiesPerInvoice)
