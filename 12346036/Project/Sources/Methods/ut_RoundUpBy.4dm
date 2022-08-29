//%attributes = {"shared":true}
// __UNIT_TEST
// Jan 2021

//unit test for roundUpBy
//Author: Amir ; converted by @tiran on Jan 2021
//Date: 20th July 2018
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("roundUpBy"; Current method name:C684; "Math")

AJ_assert($test; roundUpBy(1001; 5); 1005; "roundUp 1001 by 5"; "expected 1005")
AJ_assert($test; roundUpBy(1000; 5); 1000; "roundUp 1000 by 5"; "expected 1000")
AJ_assert($test; roundUpBy(1000.1245; 5); 1005; "roundUp 1000.1245 by 5"; "expected 1005")
AJ_assert($test; roundUpBy(1000; 0); 1000; "roundUp 1000 by 0"; "expected 1000")
AJ_assert($test; roundUpBy(1000; 0.3); 1000.2; "roundUp 1000 by 0.3"; "expected 1000.2")
AJ_assert($test; roundUpBy(0; 0); 0; "roundUp 0 by 0"; "expected 0")
AJ_assert($test; roundUpBy(0; 2); 0; "roundUp 0 by 2"; "expected 0")
AJ_assert($test; roundUpBy(0; 0.01); 0; "roundUp 0 by 0.01"; "expected 0")
AJ_assert($test; roundUpBy(0.2145; 2); 2; "roundUp 0.2145 by 2"; "expected 2")
AJ_assert($test; roundUpBy(1000.24; 0.25); 1000.25; "roundUp 1000.24 by 0.25"; "expected 1000.25")
AJ_assert($test; roundUpBy(0.66; 0.2); 0.8; "roundUp 0.66 by 0.2"; "expected 0.8")