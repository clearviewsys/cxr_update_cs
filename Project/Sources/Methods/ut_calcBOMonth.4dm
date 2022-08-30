//%attributes = {"shared":true}
// __UNIT_TEST
//AJAR Unit Test @Zoya
//08 Jan 2021
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("calcBOMonth"; Current method name:C684; "UTIL.Date")
//C_DATE($testData; $testResult)
//$testData:=newDate(00;00;00)
//$testResult:=newDate(00;00;00)


AJ_assert($test; calcBOMonth(!999-08-19!); !999-08-01!; "999-08-19"; "return 999-08-01")

AJ_assert($test; calcBOMonth(!4000-12-31!); !4000-12-01!; "4000-12-31"; "return 4000-12-01")
//AJ_assert($test;calcBOMonth(!31-12-4000!);!4000-12-01!;"4000-12-31";"return 4000-12-01")

AJ_assert($test; calcBOMonth(!2001-02-31!); !2001-02-01!; "2001-02-31"; "return 2001-02-01")
AJ_assert($test; calcBOMonth(!2000-01-01!); !2000-01-01!; "2000-01-01"; "return 2000-01-01")
AJ_assert($test; calcBOMonth(newDate(0; 0; 0)); newDate(0; 0; 0); "00-00-00"; "return 00-00-00")
AJ_assert($test; calcBOMonth(!00-01-01!); !2000-01-01!; "00-01-01"; "return 2000-01-01")
AJ_assert($test; calcBOMonth(!01-01-01!); !2001-01-01!; "01-01-01"; "return 2001-01-01")
AJ_assert($test; calcBOMonth(!21-10-31!); !2021-10-01!; "21-10-31"; "return 2021-10-01")
AJ_assert($test; calcBOMonth(!100-08-19!); !100-08-01!; "100-08-19"; "return 100-08-01")

//in the test it is shown that when a number between 1-99 is passed in as year calcBOMonth returns the following
//for numbers 1-29 it returns years 2001-2029 and for 30-99 it retuens years 1930-1999 
//it needs to be checked , in other date related methods that I have checked so far, they don't work this way
AJ_assert($test; calcBOMonth(!80-10-31!); !1980-10-01!; "80-10-31"; "return 1980-10-01")
AJ_assert($test; calcBOMonth(!80-10-31!); newDate(1; 10; 1980); "80-10-31"; "return 1980-10-01")

AJ_assert($test; calcBOMonth(!25-10-31!); !2025-10-01!; "25-10-31"; "return 2025-10-01")
AJ_assert($test; calcBOMonth(!25-10-31!); newDate(1; 10; 2025); "25-10-31"; "return 2025-10-01")

AJ_assert($test; calcBOMonth(!35-10-31!); !1935-10-01!; "a 2-digit date 35-10-31"; "return 1935-10-01")
AJ_assert($test; calcBOMonth(!35-10-31!); newDate(1; 10; 1935); "given date through new date method 35-10-31"; "return 1935-10-01")


//AJ_assert($test;calcBOMonth(!35-01-01!);cal_getBOMByDate(!35-01-01!);"given date through new date method 35-10-31";"return 1935-10-01")



/*
AJ_assert($test;calcBOMonth(!35-01-01!);calcBOYear(!35-01-01!);"given date through new date method 35-10-31";"return 1935-10-01") // fails cause 35 is not 1935
AJ_assert($test;calcBOMonth(!30-10-31!);!1930-10-01!;"30-10-31";"return 1930-10-01")
AJ_assert($test;calcBOMonth(!29-10-31!);!2029-10-01!;"29-10-31";"return 2029-10-01")
AJ_assert($test;calcBOMonth(!29-12-31!);!2029-12-01!;"29-12-31";"return 2029-12-01")
AJ_assert($test;calcBOMonth(!30-01-01!);!1930-01-01!;"30-01-01";"return 1930-01-01")
AJ_assert($test;calcBOMonth(!30-12-10!);!1930-12-01!;"30-12-10";"return 1930-12-01")
AJ_assert($test;calcBOMonth(!31-12-10!);!1931-12-01!;"31-12-10";"return 1931-12-01")
*/
