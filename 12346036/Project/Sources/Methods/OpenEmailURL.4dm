//%attributes = {}
// Goto URL ( "webaddress")

C_TEXT:C284($1)

If (Length:C16($1)>1)
	OPEN URL:C673("mailto:"+$1)
End if 