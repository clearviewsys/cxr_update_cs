//%attributes = {}
//setPrintSettingsDefault 
SET PRINT OPTION:C733(Paper option:K47:1; "Letter")  // set the print size to letter size
SET PRINT OPTION:C733(Orientation option:K47:2; 1)  // Portrait
//SET PRINT OPTION(_o_Hide printing progress option; 0)  // Display
PRINT SETTINGS:C106
printRecordUsingPrinter(->[eWires:13]; "printeWireForm"; getClientDefaultPrinterName; 0)
