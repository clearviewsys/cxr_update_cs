//%attributes = {}


C_TEXT:C284($1; reportTitle)
C_TEXT:C284($printerName; $2)

If (Count parameters:C259>=1)
	reportTitle:=$1
Else 
	reportTitle:="Report"
End if 

If (Count parameters:C259>=2)
	$printerName:=$2
Else 
	$printerName:=""
End if 


If ($printerName="")
	//Print form("printNoRecords")// removed by TB on Dec 20, 2022 as it was causing a runtime error
Else 
	SET CURRENT PRINTER:C787($printerName)
	
	setErrorTrap("Printing Disrupted")
	Print form:C5("printNoRecords")
	endErrorTrap
End if 

PAGE BREAK:C6