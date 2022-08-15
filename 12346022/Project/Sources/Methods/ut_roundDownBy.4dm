//%attributes = {"shared":true}
// __UNIT_TEST
// Jan 2021

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("roundDownBy"; Current method name:C684; "Math")

//unit test for RoundDownBy method
// author: Amir
// Date: 20th July 2018

AJ_assert($test; roundDownBy(1001; 5); 1000; "round down 1001 by 5"; "expected 1000")
AJ_assert($test; roundDownBy(1000; 5); 1000; "roundDown 1000 by 5"; "expected 1000")
AJ_assert($test; roundDownBy(1000.1245; 5); 1000; "roundDown 1000.12 by 5"; "expected 1000")
AJ_assert($test; roundDownBy(1000; 0); 1000; "roundDown 1000 by 0"; "expected 1000")
AJ_assert($test; roundDownBy(1000; 0.3); 999.9; "roundDown 1000 by 0.3"; "expected 999.9")
AJ_assert($test; roundDownBy(0; 0); 0; "roundDown 0 by 0"; "expected 0")
AJ_assert($test; roundDownBy(0; 2); 0; "roundDown 0 by 2"; "expected 0")
AJ_assert($test; roundDownBy(0; 0.01); 0; "roundDown 0 by 0.01"; "expected 0")
AJ_assert($test; roundDownBy(0.2145; 2); 0; "roundDown 0.2145.2 by 0"; "expected 0")
AJ_assert($test; roundDownBy(1000.24; 0.25); 1000; "roundDown 1000.24 by 0.25"; "expected 1000")
AJ_assert($test; roundDownBy(0.66; 0.2); 0.6; "roundDown 0.66 by 0.2"; "expected 0.6")