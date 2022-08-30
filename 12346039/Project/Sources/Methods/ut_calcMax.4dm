//%attributes = {"shared":true}
// __UNIT_TEST
//written by @Marko Jan 2021
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("calcMax"; Current method name:C684; "Math")

AJ_assert($test; calcMax(2; 4); 4; "max of number 2 and 4"; "should return the number 4")
AJ_assert($test; calcMax(-1; 3); 3; "max of number -1 and 3"; "should return the number 3")
AJ_assert($test; calcMax(1; 1); 1; "max of number 1 and 1"; "should return the number 1")
AJ_assert($test; calcMax(-1; -3); -1; "max of number -3 and -1"; "should return the number -1")
AJ_assert($test; calcMax(4.78; 3.34); 4.78; "max of number 4.78 and 3.24"; "should return the number 4.78")
AJ_assert($test; calcMax(-5.37; -4.495); -4.495; "max of number -5.37 and -4.495"; "should return the number -4.495")