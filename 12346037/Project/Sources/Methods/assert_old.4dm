//%attributes = {}
// assert (true boolean statement;method name)
C_BOOLEAN:C305($1)
C_TEXT:C284($2)

If (Not:C34($1))
	myAlert("Assertion failure in method "+$2)
	TRACE:C157
End if 