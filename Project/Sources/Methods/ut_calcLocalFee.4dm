//%attributes = {"shared":true}
// __UNIT_TEST
// @Zoya - JAn 2021
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("calcLocalFee"; Current method name:C684; "Math")

AJ_assert($test; calc_FeeLocal(True:C214; 100; "USD"; 1.3; 0; 5; 135); 5; "True;100;USD;1.3;0;5;135"; "return 5")
AJ_assert($test; calc_FeeLocal(False:C215; 100; "USD"; 1.3; 0; 5; 125); 5; "False;100;USD;1.3;0; 5;125"; "return 5")

//AJ_assert($test;calc_FeeLocal(True;100;1.3;0;5;135);0;"135 CAD to USD missing to pass Currency parameter";"not work ie. return 0")
//AJ_assert($test;calc_FeeLocal(True;"USD";1.3;0;5;135);0;"135 CAD to USD missing the Amount as a parameter";"not work ie. return 0")
AJ_assert($test; calc_FeeLocal(True:C214; 1000; "USD"; 1.3; 1; 0; 1313); 0; "1313 CAD to USD at rate 1.3 with fee 1%"; "return 0")
AJ_assert($test; calc_FeeLocal(False:C215; 1000; "USD"; 1.3; 1; 0; 1287); 0; "1000 USD to 1287 CAD to USD at rate 1.3 with fee 1%"; "return 0")

AJ_assert($test; calc_FeeLocal(True:C214; 0; "USD"; 1.3; 0; 0; 0); 0; "0 CAD to 0 USD at rate 1.3"; "return 0")

//why it doesn't round up or down to two decimals? It uses roundToBase in calc Amount Local
AJ_assert($test; calc_FeeLocal(True:C214; 0.7692307692308; "USD"; 1.3; 0; 0; 1); 0; "1 CAD to 0.7692307692308 USD at rate 1.3 "; "return 0")
AJ_assert($test; calc_FeeLocal(True:C214; -3.846153846154; "USD"; 1.3; 0; 5; 0); 5; "0 CAD to -3.846153846154 USD at rate 1.3 "; "return 5")

AJ_assert($test; calc_FeeLocal(True:C214; 20; "GBP"; 0.5; 0; -1; 9); -1; "9 CAD to 20 GBP at rate 0.5 "; "return -1")
AJ_assert($test; calc_FeeLocal(False:C215; 20; "GBP"; 0.5; 0; 0; 10); 0; "20 GBP to 10 CAD at rate 0.5 "; "return 0")
AJ_assert($test; calc_FeeLocal(True:C214; 20; "GBP"; 0.5; 0; 0; 10); 0; "10 CAD to 20 GBP at rate 0.5 "; "return 0")
AJ_assert($test; calc_FeeLocal(True:C214; 2e+14; "GBP"; 0.5; 0; 10; 1e+14); 10; "100000000000010 CAD to 200000000000000 GBP at rate 0.5 "; "return 10s")
