//%attributes = {}
// printRecordUsingPrinter (->table;formName;printerName;numberofextracopies)

C_POINTER:C301($tablePtr; $1)
C_TEXT:C284($printerName; $2; $formName; $3)
C_LONGINT:C283($extraPrints; $4; $i)


Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
		$formName:="print"
		$printerName:=getClientDefaultPrinterName
		$extraPrints:=0
	: (Count parameters:C259=1)
		$tablePtr:=$1
		$formName:="print"
		$printerName:=getClientDefaultPrinterName
		$extraPrints:=0
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$formName:=$2
		$printerName:=getClientDefaultPrinterName
		$extraPrints:=0
	: (Count parameters:C259=3)
		$tablePtr:=$1
		$formName:=$2
		$printerName:=$3
		$extraPrints:=0
	: (Count parameters:C259=4)
		$tablePtr:=$1
		$formName:=$2
		$printerName:=$3
		$extraPrints:=$4
End case 



FORM SET OUTPUT:C54($1->; $formName)

If ($printerName="")
	PRINT RECORD:C71($tablePtr->)
Else 
	SET CURRENT PRINTER:C787($printerName)
	PRINT RECORD:C71($tablePtr->; *)
	For ($i; 1; $extraPrints)
		SET CURRENT PRINTER:C787($printerName)
		PRINT RECORD:C71($tablePtr->; *)
	End for 
End if 