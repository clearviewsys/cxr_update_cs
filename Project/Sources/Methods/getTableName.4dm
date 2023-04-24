//%attributes = {}
// getTableName(table Number) -> table name
// unit test written
C_LONGINT:C283($1)
C_TEXT:C284($0)

If ($1=0)
	$0:="Default Privilege"
Else 
	$0:=Table name:C256($1)
End if 
