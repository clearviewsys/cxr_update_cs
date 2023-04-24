//%attributes = {}
C_TEXT:C284($1; $type)

If (Count parameters:C259>=1)
	$type:=$1
Else 
	$type:=""
End if 

If (getKeyValue("audit.log.registers"; "true")="true")
	UTIL_Log("registers"; $type+"\t"+UTIL_recordToText(Table:C252(->[Registers:10]); Char:C90(Tab:K15:37)))
End if 