//%attributes = {}
// Is collection or entity selection listbox column calculated based on colun firmula

C_BOOLEAN:C305($0)
C_TEXT:C284($1; $formula)

$formula:=$1

If (Match regex:C1019("[\\*/\\+-]"; $formula; 1))
	$0:=True:C214
Else 
	$0:=False:C215
End if 
