//%attributes = {}
//requestDateRangeTable (->table;->dateField;{force date range panel})
C_POINTER:C301($1; $2)
C_DATE:C307(vFromDate; vToDate)
C_LONGINT:C283($ok; $0)
If ((Count parameters:C259=3) | (Form event code:C388=On Clicked:K2:4))
	requestDateRange
	$ok:=OK
Else 
	$ok:=1
End if 

If ($ok=1)
	selectDateRangeTable($1; $2; vFromDate; vToDate)
End if 
handleVRecNum($1)
orderByTable($1)
$0:=$ok
