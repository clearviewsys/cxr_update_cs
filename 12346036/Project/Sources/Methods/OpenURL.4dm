//%attributes = {"publishedWeb":true}
// Goto URL ( "webaddress")
C_TEXT:C284($1)

If (Length:C16($1)>1)
	OPEN URL:C673($1; *)
End if 