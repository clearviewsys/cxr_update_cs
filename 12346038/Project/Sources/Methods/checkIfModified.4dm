//%attributes = {}
// checkifmodified(->field;"Message if field is modified";"warn")

C_POINTER:C301($1)
C_TEXT:C284($2)

If ((Old:C35($1->)#"") & ($1->#Old:C35($1->)))
	checkAddErrorOnTrue((Count parameters:C259=2); $2)
End if 