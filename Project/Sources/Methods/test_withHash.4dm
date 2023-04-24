//%attributes = {}
// delete this later

var $win : Integer
var $i : Integer
var $obj : Object
$obj:=New object:C1471

$obj.text:="hello world"
$obj.number:=0  // number 
$obj.DOB:=!00-00-00!  // date


For ($i; 1; 2)
	$win:=Open form window:C675("Test_Hash"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40("Test_Hash"; $obj)
End for 

$win:=Open form window:C675("Test_Hash"; Plain form window:K39:10; On the left:K39:2; Vertically centered:K39:4)

DIALOG:C40("Test_Hash"; $obj)

ALERT:C41(JSON Stringify:C1217($obj))
