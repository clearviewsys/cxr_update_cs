//%attributes = {"shared":true}
// __UNIT_TEST
//@Zoya
//10 Jan 2020

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("calcRate"; Current method name:C684; "Math")

AJ_assert($test; calc_Rate(True:C214; 100; "USD"; 1.3; 0; 5; 135); 1.3; "True;100;USD;1.3;0;5;135"; "return 1.3")
AJ_assert($test; calc_Rate(False:C215; 100; "USD"; 1.3; 0; 5; 125); 1.3; "False;100;USD;1.3;0; 5;125"; "return 1.3")

//AJ_assert($test;calc_Rate(True;100;1.3;0;5;135);0;"135 CAD to USD missing to pass Currency parameter";"not work ie. return 0")
//AJ_assert($test;calc_Rate(True;"USD";1.3;0;5;135);0;"135 CAD to USD missing the Amount as a parameter";"not work ie. return 0")
AJ_assert($test; calc_Rate(False:C215; 1000; "USD"; 1.3; 1; 0; 1287); 1.3; "1000 USD to 1287 CAD  with fee 1%"; "return 1.3")


AJ_assert($test; calc_Rate(True:C214; 1000; "AUD"; 0.75; 0; 0; 750); 0.75; "750 to 1000 AUD with 0 feelocal and 0 feePercentage"; "return 0.75")
// whay does it return a negtive number when rate is not passed in?
//AJ_assert($test;calc_Rate(True;1000;"AUD";0;0;750);0.75;"750 to 1000 AUD, missing to pass in the rate, with 0 feelocal and 0 feePercentage";"return 0.75")

AJ_assert($test; calc_Rate(True:C214; 0; "USD"; 1.3; 0; 0; 0); 0; "0 CAD to 0 USD with 0 feelocal"; "return 0")

//why it doesn't round up or down to two decimals? It uses roundToBase in calc Amount Local
AJ_assert($test; calc_Rate(True:C214; 0.7692307692308; "USD"; 1.3; 0; 0; 1); 1.3; "1 CAD to 0.7692307692308USD at rate 1.3 with 0 feelocal"; "return 1.3")
AJ_assert($test; calc_Rate(True:C214; -3.846153846154; "USD"; 1.3; 0; 5; 0); 1.3; "0 CAD to -3.846153846154USD at rate 1.3 with 5 feelocal"; "return 1.3")

AJ_assert($test; calc_Rate(True:C214; 20; "GBP"; 0.5; 0; -1; 9); 0.5; "9 CAD to 20 GBP with -1 local fee"; "return 0.5")
AJ_assert($test; calc_Rate(False:C215; 20; "GBP"; 0.5; 0; 0; 10); 0.5; "20 GBP to 10 CAD with 0 local fee"; "return 0.5")
AJ_assert($test; calc_Rate(True:C214; 20; "GBP"; 0.5; 0; 0; 10); 0.5; "10 CAD to 20 GBP with 0 local fee"; "return 0.5")
AJ_assert($test; calc_Rate(True:C214; 2e+14; "GBP"; 0.5; 0; 10; 1e+14); 0.5; "100000000000010 CAD to 200000000000000 GBP with 10 local fee"; "return 0.5")

