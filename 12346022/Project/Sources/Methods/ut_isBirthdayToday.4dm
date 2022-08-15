//%attributes = {"shared":true}
// __UNIT_TEST
// extend this Unit Test
// written by @tiran on Dec 31/2020

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("isBirthdayToday"; Current method name:C684; "UTIL.Date")

C_DATE:C307($dob)
C_TEXT:C284($given)

$dob:=!00-00-00!
$given:="an empty date"
AJ_assert($test; isBirthdayToday($dob); False:C215; $given; "today  is not a birthday")
AJ_assert($test; isBirthdayToday($dob; 0); False:C215; $given; "today+0  is not a birthday")
AJ_assert($test; isBirthdayToday($dob; 1); False:C215; $given; "tomorrow is not a birthday")

$dob:=newDate(1; 1; 2000)
$given:="dob as Jan 1 2000"

If ((Day of:C23(Current date:C33)=1) & (Month of:C24(Current date:C33)=1))  // conditional assertion
	AJ_assert($test; isBirthdayToday($dob); True:C214; $given; "today should be the birthday")
Else 
	AJ_assert($test; isBirthdayToday($dob); False:C215; $given; "today should not be the birthday")
End if 


$dob:=Current date:C33
$given:="today as the birthday"
AJ_assert($test; isBirthdayToday($dob); True:C214; $given; "today should be the birthday")
AJ_assert($test; isBirthdayToday($dob; 1); False:C215; $given; "tomorrow is not a birthday")
AJ_assert($test; isBirthdayToday($dob; -1); False:C215; $given; "yesterday is not a birthday")

$dob:=Add to date:C393(Current date:C33; 0; 0; 7)
$given:="one week from today as the birthday"
AJ_assert($test; isBirthdayToday($dob); False:C215; $given; "today is not a birthday")
AJ_assert($test; isBirthdayToday($dob; 1); False:C215; $given; "tomorrow is not a birthday")
AJ_assert($test; isBirthdayToday($dob; 7); True:C214; $given; "today+7 is a birthday")

$dob:=newDate(Day of:C23(Current date:C33); Month of:C24(Current date:C33); 2000)  // dynamically created date to be the same day and month as today year 2000
$given:=String:C10($dob)+" as a birthday"
AJ_assert($test; isBirthdayToday($dob); True:C214; $given; "today is  a birthday")
AJ_assert($test; isBirthdayToday($dob; 1); False:C215; $given; "tomorrow is not a birthday")
