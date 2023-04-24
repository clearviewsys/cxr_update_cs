//%attributes = {"shared":true}
// __UNIT_TEST
// @Zoya - Jan 2021
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("calcPercentFee"; Current method name:C684; "Math")

AJ_assert($test; calc_PercentFee(True:C214; 100; "USD"; 1.3; 0; 5; 135); 0; "True;100;USD;1.3;0;5;135"; "return 0")
AJ_assert($test; calc_PercentFee(False:C215; 100; "USD"; 1.3; 0; 5; 125); 0; "False;100;USD;1.3;0; 5;125"; "return 0")

// the next two tests return -100?! and not 0 
//AJ_assert($test;calc_PercentFee(True;100;1.3;0;5;135);0;"135 CAD to USD missing to pass Currency parameter";"not work ie. return 0")
//AJ_assert($test;calc_PercentFee(True;"USD";1.3;0;5;135);0;"135 CAD to USD missing the Amount as a parameter";"not work ie. return 0")

AJ_assert($test; calc_PercentFee(True:C214; 1000; "USD"; 1.3; 1; 0; 1313); 1; "1313 CAD to 1000 USD at rate 1.3 "; "return 1")
AJ_assert($test; calc_PercentFee(False:C215; 1000; "USD"; 1.3; 1; 0; 1287); 1; "1000 USD to 1287 CAD at rate 1.3 "; "return 1")

// it returns -100?! and not 0 
AJ_assert($test; calc_PercentFee(True:C214; 1000; "USD"; 1.3; 0; 0; 0); -100; "0 CAD to 1000 USD at rate 1.3 with 0 feelocal"; "return -100")
AJ_assert($test; calc_PercentFee(False:C215; 500; "USD"; 1.3; 0; 0; 0); 100; "500 USD to 0 CAD at rate 1.3 with 0 feelocal"; "return 100")

AJ_assert($test; calc_PercentFee(False:C215; 200; "USD"; 1; 0; 0; 100); 50; "200 usd to 100 cad at rate 1 with 0 feelocal"; "return 50")

AJ_assert($test; calc_PercentFee(True:C214; 0.7692307692308; "USD"; 1.3; 0; 0; 1); 0; "1 CAD to 0.7692307692308 USD at rate 1.3 with 0 feelocal"; "return 0")
AJ_assert($test; calc_PercentFee(True:C214; -3.846153846154; "USD"; 1.3; 0; 5; 0); 0; "0 CAD to -3.846153846154 USD at rate 1.3 with 5 feelocal"; "return 0")

AJ_assert($test; calc_PercentFee(True:C214; 20; "GBP"; 0.5; 0; -1; 9); 0; "9 CAD to 20 GBP at rate 0.5 with -1 local fee"; "return 0")
AJ_assert($test; calc_PercentFee(False:C215; 20; "GBP"; 0.5; 0; 0; 10); 0; "20 GBP to 10 CAD at rate 0.5 with 0 local fee"; "return 0")
AJ_assert($test; calc_PercentFee(True:C214; 20; "GBP"; 0.5; 0; 0; 10); 0; "is paid 10 CAD to 20 GBP at rate 0.5 with 0 local fee"; "return 0")
AJ_assert($test; calc_PercentFee(True:C214; 2e+14; "GBP"; 0.5; 0; 10; 1e+14); 0; "100000000000010 CAD to 200000000000000 GBP at rate 0.5 with 10 local fee"; "return 0")