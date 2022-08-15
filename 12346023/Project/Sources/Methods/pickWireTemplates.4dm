//%attributes = {}
C_POINTER:C301($1)
C_TEXT:C284($2; vQueryCommand)
If (Count parameters:C259=2)
	vQueryCommand:=$2
Else 
	vQueryCommand:=""
End if 


pickRecordForTable(->[WireTemplates:42]; ->[WireTemplates:42]WireTemplateID:1; $1)