//%attributes = {}
#DECLARE($chain : Collection)

var $formObj : Object
var $winref : Integer

$formObj:=New object:C1471
If (Count parameters:C259=0)
	$chain:=Get call chain:C1662
End if 

$formObj.json:=JSON Stringify:C1217($chain; *)

$winref:=Open form window:C675("displayJSON")

DIALOG:C40("displayJSON"; $formObj)

CLOSE WINDOW:C154($winref)
