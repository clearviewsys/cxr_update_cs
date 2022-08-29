//%attributes = {}
// printThisInvoiceAsPDF (path: text): path
// returns the path of the pdf file

C_TEXT:C284($1; $tPath)

C_TEXT:C284($0)  //path of the PDF


If (Count parameters:C259>=1)
	$tPath:=$1  //should really test the path to make sure it will work
Else 
	$tPath:=Temporary folder:C486+vInvoiceNumber+".pdf"
End if 


orderByRegisters

FORM SET OUTPUT:C54([Registers:10]; getKeyValue("Invoice.print.PDF"; "printInvoice_Large"))


setPrintOrientation(True:C214)  // portrait
//setPrintScale (getClientReceiptScale )
//getKeyValueDescription
setPrintPaperName(getKeyValue("Invoice.print.PDF.pageFormat"; "Letter"))


$0:=printThisAsPDF_(->[Registers:10]; $tPath)