//%attributes = {"shared":true}
// __UNIT_TEST
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("GetCountryCode"; Current method name:C684; "GET")
AJ_assert($test; getCountryCode("Iran"); ""; "Iran"; "return void")
AJ_assert($test; getCountryCode("Iran, Islamic Republic of"); "IR"; "Iran, Islamic Republic of"; "return IR")
AJ_assert($test; getCountryCode("yyyyy"); ""; "yyyyy"; "return void")
//AJ_assert($test; getCountryCode("1111"); ""; "1111"; "return void")