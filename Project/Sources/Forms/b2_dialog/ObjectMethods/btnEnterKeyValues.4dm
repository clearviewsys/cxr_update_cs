var $winref : Integer
var $formObj : Object

$winref:=Open form window:C675("b2_enterCredentials")

DIALOG:C40("b2_enterCredentials"; $formObj)

CLOSE WINDOW:C154($winref)

If (OK=1)
	
	Form:C1466.b2:=b2_getKeyValues
	
End if 
