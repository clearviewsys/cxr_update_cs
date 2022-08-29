//%attributes = {}
// getElegantTableNameByNum (tableNum) -> string

// see also : getElegantTableName ...


C_LONGINT:C283($1)
C_TEXT:C284($0)

If ($1>0)
	$0:=getElegantTableName(Table:C252($1))
Else 
	$0:=""
End if 
