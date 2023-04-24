//%attributes = {}
C_TEXT:C284($1; $printer)
C_TEXT:C284($0)

C_LONGINT:C283($pos)

$printer:=$1

If (getKeyValue("rdc.print.redirect"; "false")="True")
	$pos:=Position:C15("(redirected"; $printer)
	If ($pos>0)
		$printer:=Substring:C12($printer; 1; $pos-2)
	End if 
End if 

$0:=$printer