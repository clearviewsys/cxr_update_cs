//%attributes = {}
//setPrintSettingsDefault 
//OUTPUT FORM([Wires];"printWireForm")
//PRINT RECORD([Wires])

C_TEXT:C284($format)
$format:=getClientDefaultPageFormat
If ($format="")
	$format:="Letter"
End if 

SET PRINT OPTION:C733(Paper option:K47:1; $format)  // set the print size to letter size
SET PRINT OPTION:C733(Orientation option:K47:2; 1)  // Portrait
//SET PRINT OPTION(_o_Hide printing progress option; 0)  // Display
PRINT SETTINGS:C106

printRecordUsingPrinter(->[Wires:8]; "printWireForm"; getClientDefaultPrinterName; 0)
