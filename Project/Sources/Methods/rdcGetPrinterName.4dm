//%attributes = {}
C_TEXT:C284($1; $printerName)
C_TEXT:C284($0)

C_LONGINT:C283($elem)

$printerName:=$1

If (getKeyValue("rdc.print.redirect"; "false")="true")  //@ibb for RDC servers
	ARRAY TEXT:C222($atNames; 0)
	PRINTERS LIST:C789($atNames)
	
	$elem:=Find in array:C230($atNames; $printerName+"@")
	If ($elem>0)
		$printerName:=$atNames{$elem}  //this should add the (redirected 4) to the printer name
	End if 
End if 

$0:=$printerName