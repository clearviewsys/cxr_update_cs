//%attributes = {"shared":true}
// __UNIT_TEST
//@Zoya
//9 Jan 2021

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("cal_getBOMByDate"; Current method name:C684; "UTIL.Date")


AJ_assert($test; cal_getBOMByDate(!999-08-19!); !999-08-01!; "#1: 999-08-19"; "return 999-08-01")

AJ_assert($test; cal_getBOMByDate(!4000-12-31!); !4000-12-01!; "#2: 4000-12-31"; "return 4000-12-01")
AJ_assert($test; cal_getBOMByDate(!2001-02-31!); !2001-02-01!; "#3: 2001-02-31"; "return 2001-02-01")
AJ_assert($test; cal_getBOMByDate(!2000-01-01!); !2000-01-01!; "#4: 2000-01-01"; "return 2000-01-01")

AJ_assert($test; cal_getBOMByDate(!00-00-00!); !00-00-00!; "#5: 0000-00-00"; "return 0000-00-00")
AJ_assert($test; cal_getBOMByDate(!00-01-01!); newDate(0; 0; 0); "#6: 00-01-01"; "return 2000-01-01")
AJ_assert($test; cal_getBOMByDate(!01-01-01!); newDate(1; 1; 1); "#7: 01-01-01"; "return 2001-01-01")
AJ_assert($test; cal_getBOMByDate(!80-10-31!); newDate(1; 10; 80); "#8: 80-10-31"; "return 1980-10-01")
AJ_assert($test; cal_getBOMByDate(!21-10-31!); newDate(1; 10; 21); "#9: 21-10-31"; "return 2021-10-01")
AJ_assert($test; cal_getBOMByDate(!100-08-19!); newDate(1; 8; 100); "#10: 100-08-19"; "return 100-08-01")
/*AJ_assert($test;cal_getBOMByDate(!25-10-31!);!2025-10-01!;"25-10-31";"return 2025-10-01")

AJ_assert($test;cal_getBOMByDate(!35-10-31!);newDate(01;10;35);"35-10-31";"return 1935-10-01")
AJ_assert($test;cal_getBOMByDate(!30-10-31!);!1930-10-01!;"30-10-31";"return 1930-10-01")

AJ_assert($test;cal_getBOMByDate(!29-10-31!);!2029-10-01!;"29-10-31";"return 2029-10-01")
AJ_assert($test;cal_getBOMByDate(!29-12-31!);!2029-12-01!;"29-12-31";"return 2029-12-01")
AJ_assert($test;cal_getBOMByDate(!30-01-01!);!1930-01-01!;"30-01-01";"return 1930-01-01")
AJ_assert($test;cal_getBOMByDate(!30-12-10!);!1930-12-01!;"30-12-10";"return 1930-12-01")
AJ_assert($test;cal_getBOMByDate(!31-12-10!);!1931-12-01!;"31-12-10";"return 1931-12-01")
*/
