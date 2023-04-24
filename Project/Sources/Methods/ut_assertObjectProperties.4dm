//%attributes = {"shared":true}
// Author: Wai-Kin
// UNIT_TEST

C_OBJECT:C1216($default; $argument; $data; $expect)
var $test : Object
$test:=AJ_UnitTest.new("utils_setupObjectProperties"; Current method name:C684; "UTILS")

var $noChange : Text
$noChange:="All default values"

$default:=New object:C1471("key1"; "default")
$default.child:=New object:C1471("subobject"; !12-12-22!)
$default.emptyChild:=New object:C1471
$default.list:=New collection:C1472(123; 231; 231)

$test.given:="Null"
$test.should:=$noChange
$test.expected:=OB Copy:C1225($default)
$test.actual:=utils_setupObjectProperties($default; Null:C1517)
$test.assert()

$argument:=New object:C1471("wrong"; "value1")
$test.given:="wrong key name"
$test.should:=$noChange
$test.expected:=OB Copy:C1225($default)
$test.actual:=utils_setupObjectProperties(OB Copy:C1225($default); $argument)
$test.assert()

$argument:=New object:C1471("key1"; 123)
$test.given:="wrong key value type"
$test.should:=$noChange
$test.expected:=OB Copy:C1225($default)
$test.actual:=utils_setupObjectProperties(OB Copy:C1225($default); $argument)
$test.assert()

$expect:=OB Copy:C1225($default)
$expect.key1:="value"
$argument:=New object:C1471("key1"; "value")
$test.given:="acceptable child value"
$test.should:="new value for key"
$test.expected:=$expect
$test.actual:=utils_setupObjectProperties(OB Copy:C1225($default); $argument)
$test.assert()

$argument:=New object:C1471("child"; New object:C1471("subobject"; 123))
$test.given:="acceptable child value"
$test.should:="new value for key"
$test.expected:=OB Copy:C1225($default)
$test.actual:=utils_setupObjectProperties(OB Copy:C1225($default); $argument)
$test.assert()

$expect:=OB Copy:C1225($default)
$expect.child.subobject:=!1999-11-09!
$argument:=New object:C1471("child"; New object:C1471("subobject"; !1999-11-09!))
$test.given:="acceptable child value"
$test.should:="new value for key"
$test.expected:=OB Copy:C1225($default)
$test.actual:=utils_setupObjectProperties(OB Copy:C1225($default); $argument)
$test.assert()

$expect:=OB Copy:C1225($default)
$argument:=New object:C1471("emptyChild"; 122)
$data:=utils_setupObjectProperties(OB Copy:C1225($default); $argument)

$expect.emptyChild:=New object:C1471("optional"; 23)
$argument:=New object:C1471("emptyChild"; New object:C1471("optional"; 23))
$data:=utils_setupObjectProperties(OB Copy:C1225($data); $argument)
