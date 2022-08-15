//%attributes = {"shared":true}
// __UNIT_TEST
//@Zoya 
//@07 Mar 2021
//it needs to be confirmed for line 16 & 17 when we pass true or false it gives same result 

C_OBJECT:C1216($test)
C_TEXT:C284($result1; $result2; $result3; $input1)
$test:=AJ_UnitTest.new("FJ_MaxString"; Current method name:C684; "No Category")
$input1:="You must specify? a field 54 type for each field."
$result1:="You must"
$result2:="You must\nspecify? a\nfield 54\ntype for\neach\nfield."
$result3:="You must\nspecify? a"
AJ_assert($test; FJ_MaxString(""; 10); ""; "an empty string"; "return an empty string")
AJ_assert($test; FJ_MaxString($input1; 10); $result1; $input1; "return 'You must'")
AJ_assert($test; FJ_MaxString($input1; 10; 10); $result2; $input1; "return "+$result2)
AJ_assert($test; FJ_MaxString($input1; 10; 2); $result3; $input1; "return "+$result3)
AJ_assert($test; FJ_MaxString($input1; 10; 2; True:C214); $result3; $input1; "return "+$result3)
AJ_assert($test; FJ_MaxString($input1; 10; 2; False:C215); $result3; $input1; "return "+$result3)


