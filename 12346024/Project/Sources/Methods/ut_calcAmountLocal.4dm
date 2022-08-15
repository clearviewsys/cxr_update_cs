//%attributes = {"shared":true}
// __UNIT_TEST
//@Zoya - Jan 2021

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("calcAmountLocal"; Current method name:C684; "Math")

AJ_assert($test; calc_AmountLocal(True:C214; 100; "USD"; 1.3; 0; 5; 135); 135; "True;100;USD;1.3;0;5;135"; "return 135")
AJ_assert($test; calc_AmountLocal(False:C215; 100; "USD"; 1.3; 0; 5; 125); 125; "False;100;USD;1.3;0; 5;125"; "return 125")
AJ_assert($test; calc_AmountLocal(True:C214; 59.75; "USD"; 1.326; 0; 0; 0); 79.2285; "cad to 1000 USD at rate 1.3 with fee 1%"; "return 1313")

//the next two tests would return 0 in calc_Amount, as it is required to pass in all the 7 parameters
//however here it doesnt make any problem! (it had syntax error)
//AJ_assert($test;calc_AmountLocal(True;100;1.3;0;5;135);0;"100 USD to CAD missing to pass Currency parameter";"not work ie. return 0")
//AJ_assert($test;calc_AmountLocal(True;"USD";1.3;0;5;135);0;" hhhhhhh missing the Amount as a parameter";"not work ie. return 0")

AJ_assert($test; calc_AmountLocal(True:C214; 1000; "USD"; 1.3; 1; 0; 1313); 1313; "cad to 1000 USD at rate 1.3 with fee 1%"; "return 1313")
AJ_assert($test; calc_AmountLocal(False:C215; 1000; "USD"; 1.3; 1; 0; 1287); 1287; "1000 USD to CAD at rate 1.3 with fee 1%"; "return 1287")
AJ_assert($test; calc_AmountLocal(True:C214; 0; "USD"; 1.3; 0; 0; 0); 0; "0 CAD to USD at rate 1.3 with 0 feelocal"; "return 0")
AJ_assert($test; calc_AmountLocal(True:C214; 0.7692307692308; "USD"; 1.3; 0; 0; 1); 1; "cad to 0.7692307692308 USD at rate 1.3 with 0 feelocal"; "return 1")
AJ_assert($test; calc_AmountLocal(True:C214; -3.846153846154; "USD"; 1.3; 0; 5; 0); 0; "cad to -3.846153846154 USD at rate 1.3 with 5 feelocal"; "return 0")

AJ_assert($test; calc_AmountLocal(True:C214; 20; "GBP"; 0.5; 0; -1; 9); 9; "cad to 20 GBP at rate 0.5 with -1 local fee"; "return 9")
AJ_assert($test; calc_AmountLocal(False:C215; 20; "GBP"; 0.5; 0; 0; 10); 10; "20 GBP to CAD at rate 0.5 with 0 local fee"; "return 10")
AJ_assert($test; calc_AmountLocal(True:C214; 20; "GBP"; 0.5; 0; 0; 10); 10; "cad to 20 GBP at rate 0.5 with 0 local fee"; "return 10")
AJ_assert($test; calc_AmountLocal(True:C214; 2e+14; "GBP"; 0.5; 0; 10; 1e+14); 1e+14; "200000000000000 GBP at rate 0.5 with 10 local fee"; "return 100000000000010")





