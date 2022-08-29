//%attributes = {"shared":true}
// _UNIT_TEST

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("My Test Description"; Current method name:C684)

ASSERT:C1129(2*2=4; "multiply 2*2 should be 4")
AJ_assert($test; 2*2; 4; "2 * 2 "; "4")