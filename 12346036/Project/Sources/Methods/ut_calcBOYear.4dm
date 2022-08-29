//%attributes = {"shared":true}
// __UNIT_TEST
// @Zoya
//9 Jan 2021
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("calcBOYear"; Current method name:C684; "UTIL.Date")

C_DATE:C307($date; $boy)  // added by @tiran
$date:=newDate(10; 1; 2000)  // this is 10 th of January 2000
$boy:=newDate(1; 1; 2000)  // this is 1st of January 2000
AJ_assert($test; calcBOYear($date); $boy; "calcBOYear(10/1/2000)"; "1/1/2000")

// this is 10th day of the current month
// this is 1st of January 2021
AJ_assert($test; calcBOYear(newDate(10)); newDate(1; 1; Year of:C25(Current date:C33)); "calcBOYear(newDate(10))"; "Jan 1st of this year")

// this is 10th day of 5th month of the current year
AJ_assert($test; calcBOYear(newDate(10; 5)); newDate(1; 1; Year of:C25(Current date:C33)); "10 as day and 05 as month"; "1/1/"+String:C10(Year of:C25(Current date:C33)))


//$date:=newDate(2000)  // 
//$boy:=newDate(1;1;2026)  // 
//AJ_assert($test;calcBOYear($date);$boy;"10 as day and 05 as month";"1/1/2026")

AJ_assert($test; calcBOYear(newDate(25; 10; 2025)); newDate(1; 1; 2025); "25/10/2025"; "return 1/1/2025")

AJ_assert($test; calcBOYear(newDate(3; 3; 1000)); newDate(1; 1; 1000); "3/3/1000"; "1/1/1000")
AJ_assert($test; calcBOYear(newDate(10; 12; 2012)); newDate(1; 1; 2012); "10 Dec 2012"; "1 Jan 2012")  // @tiran fixed 

AJ_assert($test; calcBOYear(!00-00-00!); !00-00-00!; "calcBOYEar(00-00-00)"; "return 00-00-00")  // boundary test

AJ_assert($test; calcBOYear(!1980-10-31!); !1980-01-01!; "80-10-31"; "return 1980-01-01")

AJ_assert($test; calcBOYear(!2029-12-31!); !2029-01-01!; "!2029-12-31!"; "return 2029-01-01")  // @tiran fixed

AJ_assert($test; calcBOYear(!4000-12-31!); !4000-01-01!; "!4000-12-31!"; "return 4000-01-01")
AJ_assert($test; calcBOYear(!999-08-19!); !999-01-01!; "999-08-19"; "return 999-01-01")
AJ_assert($test; calcBOYear(!2000-01-01!); !2000-01-01!; "2000-01-01"; "return 2000-01-01")
AJ_assert($test; calcBOYear(!2029-10-31!); !2029-01-01!; "2029-10-31"; "return 2029-01-01")
AJ_assert($test; calcBOYear(!100-08-19!); !100-01-01!; "100-08-19"; "return 100-01-01")
AJ_assert($test; calcBOYear(!1931-12-10!); !1931-01-01!; "1931-12-10"; "return 1931-01-01")
AJ_assert($test; calcBOYear(!1930-10-31!); !1930-01-01!; "30-10-31"; "return 1930-01-01")
AJ_assert($test; calcBOYear(!01-01-01!); !01-01-01!; "01-01-01"; "return 01-01-01")

// Hi @Zoya I commented out the following code because it's really dependent on the format of the system
// Hi @tiran : the reason the following test fails is you assume 30 is 1930 or 21 is the same as 2021
/*
AJ_assert($test;calcBOYear(!21-10-31!);!2021-01-01!;"21-10-31";"return 2021-01-01")
AJ_assert($test;calcBOYear(!35-10-31!);!1935-01-01!;"35-10-31";"return 1935-01-01")
AJ_assert($test;calcBOYear(!30-01-01!);!1930-01-01!;"30-01-01";"return 1930-01-01")
AJ_assert($test;calcBOYear(!30-12-10!);!1930-01-01!;"30-12-10";"return 1930-01-01")
*/
