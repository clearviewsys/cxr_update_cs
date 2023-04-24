//%attributes = {"shared":true}
// __UNIT_TEST
// Author: Wai-Kin
// Jan 2021r

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("slold_setOrGetSanctionFlag"; Current method name:C684; "AML.Sanction Check")

C_LONGINT:C283($value)
$value:=2

C_TEXT:C284($given)
$given:=String:C10($value)

$test.given:="Customer Flag for "+$given+" with number"
$test.should:="Return False"
$test.expected:=False:C215
$test.actual:=slold_setOrGetSanctionFlag(->$value; 0)
$test.assert()

$test.given:="Customer Flag for "+$given+" with name"
$test.should:="Return False"
$test.expected:=False:C215
$test.actual:=slold_setOrGetSanctionFlag(->$value; "Customer")
$test.assert()

$test.given:="Invoice Flag for "+$given+" with number"
$test.should:="Return True"
$test.expected:=True:C214
$test.actual:=slold_setOrGetSanctionFlag(->$value; 1)
$test.assert()

$test.given:="Invoice Flag for "+$given+" with name"
$test.should:="Return True"
$test.expected:=True:C214
$test.actual:=slold_setOrGetSanctionFlag(->$value; "Invoice")
$test.assert()

slold_setOrGetSanctionFlag(->$value; 0; 1)
$given:=String:C10($value)

$test.given:="After setting Customer to true"
$test.should:="Return 3"
$test.expected:=3
$test.actual:=$value
$test.assert()

$test.given:="Customer Flag for "+$given
$test.should:="Return True"
$test.expected:=True:C214
$test.actual:=slold_setOrGetSanctionFlag(->$value; 0)
$test.assert()

slold_setOrGetSanctionFlag(->$value; 0; 0)
$given:=String:C10($value)

$test.given:="After toggling Customer to false"
$test.should:="Return 2"
$test.expected:=2
$test.actual:=$value
$test.assert()

$test.given:="Customer Flag for "+$given
$test.should:="Return False"
$test.expected:=False:C215
$test.actual:=slold_setOrGetSanctionFlag(->$value; 0)
$test.assert()

slold_setOrGetSanctionFlag(->$value; 0; 0)
$given:=String:C10($value)

$test.given:="After toggle Customer to true"
$test.should:="Return 3"
$test.expected:=3
$test.actual:=$value
$test.assert()

$test.given:="Customer Flag for "+$given
$test.should:="Return True"
$test.expected:=True:C214
$test.actual:=slold_setOrGetSanctionFlag(->$value; 0)
$test.assert()

slold_setOrGetSanctionFlag(->$value; 0; -1)
$given:=String:C10($value)

$test.given:="After setting Customer to false"
$test.should:="Return 2"
$test.expected:=2
$test.actual:=$value
$test.assert()

$test.given:="Customer Flag for "+$given
$test.should:="Return False"
$test.expected:=False:C215
$test.actual:=slold_setOrGetSanctionFlag(->$value; 0)
$test.assert()