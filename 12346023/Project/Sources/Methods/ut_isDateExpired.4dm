//%attributes = {"shared":true}
//@Zoya
//12 Jan 2021
//Editted 17 JAn 2021
// __UNIT_TEST

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("isDateExpired"; Current method name:C684; "UTIL.Date")
C_DATE:C307($testDate)
$testDate:=newDate(2; 8; 2000)
//is this ok? or we need to add another condition inthe original method
//AJ_assert($test;isDateExpired(!00-00-00!);True;"!00-00-00!";"return True")
//AJ_assert($test;isDateExpired(!2021-01-30!);True;"!00-00-00!";"return True")
AJ_assert($test; isDateExpired(Current date:C33); True:C214; "current date"; "return True")
AJ_assert($test; isDateExpired(Current date:C33+1); False:C215; "current date +1"; "return False")
AJ_assert($test; isDateExpired(Current date:C33-1); True:C214; "current date-1"; "return True")
AJ_assert($test; isDateExpired($testDate); True:C214; "2;8;2000"; "return True")
$testDate:=newDate(2; 8; 2021)
AJ_assert($test; isDateExpired($testDate); False:C215; "2;8;2021"; "return False")
$testDate:=newDate(1)
AJ_assert($test; isDateExpired($testDate); True:C214; "1 to be added to curent date"; "return True")





