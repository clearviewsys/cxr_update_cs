//%attributes = {"shared":true}
// __UNIT_TEST
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("getCountryNameByCode"; Current method name:C684; "GET")
AJ_assert($test; getCountryNameByCode("CA"); "Canada"; "CA"; "return Canada")
AJ_assert($test; getCountryNameByCode("IR"); "Iran, Islamic Republic of"; "IR"; "return Iran, Islamic Republic of")
AJ_assert($test; getCountryNameByCode("yti"); ""; "yti"; "return void")
