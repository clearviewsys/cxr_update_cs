//%attributes = {"shared":true}
// __UNIT_TEST
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("getAbbrMonthName"; Current method name:C684; "GET")

AJ_assert($test; getAbbrMonthName(50); "Feb"; "50"; "return Feb")
AJ_assert($test; getAbbrMonthName(0); ""; "0"; "return void")
//AJ_assert($test; getAbbrMonthName("A"); ""; "A"; "return void")