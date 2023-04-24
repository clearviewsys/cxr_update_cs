//%attributes = {}
// printSelectionUsingPrinter(->table;formName;printerName;numberofextracopies)

C_POINTER:C301($1)
C_TEXT:C284($printerName; $2; $formName; $3)
C_LONGINT:C283($extraPrints; $4)

$formName:=$2
$printerName:=$3
$extraPrints:=$4

FORM SET OUTPUT:C54($1->; $formName)

If ($printerName="")
	PRINT SELECTION:C60($1->)
Else 
	$printerName:=rdcGetPrinterName($printerName)
	SET CURRENT PRINTER:C787($printerName)
	
	setPrintNumberOfCopies($extraPrints+1)
	setErrorTrap("Printing Disrupted")
	PRINT SELECTION:C60($1->; *)
	endErrorTrap
End if 