//%attributes = {"shared":true}
// __UNIT_TEST
//Jan 2021

C_OBJECT:C1216($test)
C_DATE:C307($date1; $date2; $date0; $date3)

$test:=AJ_UnitTest.new("calcMinDate"; Current method name:C684; "UTIL.Date")

$date0:=!00-00-00!  // null date
$date1:=newDate(1; 2; 2020)  // Feb 1, 2020
$date2:=newDate(1; 2; 2021)  // Feb 1, 2021
$date3:=newDate(12; 12; 2012)


AJ_assert($test; calcMinDate($date1; $date2); $date1; "minimum date between"+String:C10($date1)+" and "+String:C10($date2); String:C10($date1))
AJ_assert($test; calcMinDate($date2; $date1); $date1; "minimum date between"+String:C10($date2)+" and "+String:C10($date1); String:C10($date1))
AJ_assert($test; calcMinDate($date0; $date2); $date0; "minimum date between"+String:C10($date0)+" and "+String:C10($date2); String:C10($date0))
AJ_assert($test; calcMinDate(Current date:C33; Current date:C33-1); Current date:C33-1; "minimum date between today and yesterday"; String:C10(Current date:C33-1))
AJ_assert($test; calcMinDate(Current date:C33; Current date:C33+1); Current date:C33; "minimum date between today and tomorrow"; String:C10(Current date:C33))

//AJ_assert($test; calcMinDate($date1; $date2; date3; date0); $date0; "minimum date between"+String($date1)+" and "+String($date2)+"and"+String($date3)+"and"+String($date0); String($date0))




//AJ_assert($test;Function (...;...);result;"plain english description of the function ";"plain english description of the result")
