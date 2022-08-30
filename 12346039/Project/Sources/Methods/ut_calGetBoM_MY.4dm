//%attributes = {"shared":true}
// __UNIT_TEST
//@Zoya
//9 JAn 2021

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("cal_getBOM_MY"; Current method name:C684; "UTIL.Date")

AJ_assert($test; cal_getBOM_MY(8; 2020); !2020-08-01!; "08 as month, 2020 as year"; "return 2020-08-01")
AJ_assert($test; cal_getBOM_MY(0; 0); !00-00-00!; "00 as month, 00 as year"; "return 00-00-00")

//is the following test fine or is it required to do sth about it in the method?
AJ_assert($test; cal_getBOM_MY(4); newDate(0; 0; 0); " to pass only one number as parameter"; "return 00-00-00 or an error")

AJ_assert($test; cal_getBOM_MY(10; 30; 8); newDate(1; 10; 30); " to pass three number as parameter"; "return 30-10-01")
AJ_assert($test; cal_getBOM_MY(13; 10); newDate(1; 1; 11); " to pass in a larger than 12 as month, e.g (13;10) "; "return 1-1-11")

AJ_assert($test; cal_getBOM_MY(2; 45500); newDate(1; 2; 45500); " to pass in a more than 4 digits as year"; "return 00-00-00 or an error")
AJ_assert($test; cal_getBOM_MY(2; 4550); newDate(1; 2; 4550); " to pass in a large number (yet with 4 digits) as year e.g.(2;4550)"; "return 1-2-4550")

AJ_assert($test; cal_getBOM_MY(12; 50; 40); newDate(1; 12; 50); " to pass three numbers as parameters, (more than required by the method)"; "return 1-12-50")

