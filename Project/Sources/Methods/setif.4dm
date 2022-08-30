//%attributes = {}
// setif(condition;->var;->valueiftrue)
C_BOOLEAN:C305($1)
C_POINTER:C301($2; $3)

If ($1)
	$2->:=$3->
End if 