//%attributes = {"shared":true}
//@Zoya
//13 Jan 2021

// __UNIT_TEST
C_OBJECT:C1216($test)
//$test:=AJ_UnitTest.new("calcvAmount";Current method name;"Math Functions")

//AJ_assert($test;calcvAmount(True;100;"USD";1.3;0;5;135);100;"True;100;USD;1.3;0;5;135";"return 100")
/*AJ_assert($test;calcvAmount(False;100;"USD";1.3;0;5;125);100;"False;100;USD;1.3;0; 5;125";"return 100")

AJ_assert($test;calc_Amount(True;100;1.3;0;5;135);0;"135 CAD to USD missing to pass Currency parameter";"not work ie. return 0")
AJ_assert($test;calc_Amount(True;"USD";1.3;0;5;135);0;"135 CAD to USD missing the Amount as a parameter";"not work ie. return 0")
AJ_assert($test;calc_Amount(True;1000;"USD";1.3;1;0;1313);1000;"1313 CAD to USD at rate 1.3 with fee 1%";"return 1000")
AJ_assert($test;calc_Amount(False;1000;"USD";1.3;1;0;1287);1000;"is paid false, 1287 CAD to USD at rate 1.3 with fee 1%";"return 1000")

AJ_assert($test;calc_Amount(True;0;"USD";1.3;0;0;0);0;"0 CAD to USD at rate 1.3 with 0 feelocal";"return 0")

//why it doesn't round up or down to two decimals? It uses roundToBase in calc Amount Local
AJ_assert($test;calc_Amount(True;0;"USD";1.3;0;0;1);0.7692307692308;"1 CAD to USD at rate 1.3 with 0 feelocal";"return 0.7692307692308")
AJ_assert($test;calc_Amount(True;0;"USD";1.3;0;5;0);-3.846153846154;"0 CAD to USD at rate 1.3 with 5 feelocal";"return -3.846153846154")

AJ_assert($test;calc_Amount(True;20;"GBP";0.5;0;-1;9);20;"9 CAD to GBP at rate 0.5 with -1 local fee";"return 20")
AJ_assert($test;calc_Amount(False;20;"GBP";0.5;0;0;10);20;"is not paid 10 CAD to GBP at rate 0.5 with 0 local fee";"return 20")
AJ_assert($test;calc_Amount(True;20;"GBP";0.5;0;0;10);20;"is paid 10 CAD to GBP at rate 0.5 with 0 local fee";"return 20")
AJ_assert($test;calc_Amount(True;2e+14;"GBP";0.5;0;10;1e+14);2e+14;"100000000000010 CAD to GBP at rate 0.5 with 10 local fee";"return 200000000000000")*/