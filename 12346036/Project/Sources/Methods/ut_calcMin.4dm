//%attributes = {"shared":true}
// __UNIT_TEST
// written by @marko - Jan 2021
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("calcMin"; Current method name:C684; "Math")

AJ_assert($test; calcMin(2; 4); 2; "min of number 2 and 4"; "should return the number2")
AJ_assert($test; calcMin(-1; 3); -1; "min of number -1 and 3"; "should return the number -1")
AJ_assert($test; calcMin(1; 1); 1; "min of number 1 and 1"; "should return the number 1")
AJ_assert($test; calcMin(-1; -3); -3; "min of number -3 and -1"; "should return the number -3")
AJ_assert($test; calcMin(4.78; 3.34); 3.34; "min of number 4.78 and 3.24"; "should return the number 3.24")
AJ_assert($test; calcMin(-5.37; -4.495); -5.37; "min of number -5.37 and -4.495"; "should return the number -5.37")