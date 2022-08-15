//%attributes = {"shared":true}
// __UNIT_TEST
//by @Zoya
C_OBJECT:C1216($test)

$test:=AJ_UnitTest.new("FJGetValue"; Current method name:C684; "No Category")
AJ_assert($test; FJ_GetValue("hello"); "hello"; "'hello' as value"; "return 'hello' in return")

AJ_assert($test; FJ_GetValue(""; "fieldname"); " *MISSING* fieldname"; "no value and 'fieldname' as field description"; "return ' *MISSING* fieldname' in return")

AJ_assert($test; FJ_GetValue("myvalue"; "fieldname"); "myvalue"; "'myvalue' as value and 'fieldname' as field description"; "return 'myvalue' in return")

