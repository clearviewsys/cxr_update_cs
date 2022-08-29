//%attributes = {}
// checkifReservedBySystem(->[table];->reservedBySystemField;"WARN")

C_POINTER:C301($1; $2)
C_LONGINT:C283($count)

SET QUERY DESTINATION:C396(Into variable:K19:4; $count)
QUERY SELECTION:C341($1->; $2->=True:C214)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If ($count>0)
	checkAddErrorOnTrue((Count parameters:C259=2); "Some "+getElegantTableName($1)+" are reserved by the system.")
End if 