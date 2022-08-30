//%attributes = {"shared":true}
// __UNIT_TEST
//@Zoya - June 2021
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("checkPasswordExpired"; Current method name:C684; "Validation")

AJ_assert($test; checkPasswordExpired(Current date:C33); False:C215; "user's force password reset date as Current date"; "retrun False")
AJ_assert($test; checkPasswordExpired(Current date:C33-1); True:C214; "user's force password reset date as yesterday"; "retrun True")
AJ_assert($test; checkPasswordExpired(Current date:C33+1); False:C215; "user's force password reset date as tomorrow"; "retrun False")

/*C_BOOLEAN($test1; $test2)

QUERY([Users]; [Users]UserName="TestUserNov27")

//To test for a user, set the date below to the intended reset date
//Entering a date before today will cause an error on login
//[Users]forceResetDate:=Date("11/2/19")

SAVE RECORD([Users])
UNLOAD RECORD([Users])

$test1:=checkPasswordExpired(Date("10/6/19"))
$test2:=checkPasswordExpired(Date("00/00/00"))*/