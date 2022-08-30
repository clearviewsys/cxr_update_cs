//%attributes = {"shared":true}
// __UNIT_TEST
//converted @Zoya

C_OBJECT:C1216($test)

$test:=AJ_UnitTest.new("ut_AddUsedPassword"; Current method name:C684; "Validation")

C_OBJECT:C1216($options)
C_TEXT:C284($password1; $password2; $password3; $password4; $REPEATEDPASS3)
//C_BOOLEAN($test1; $test2; $test3; $test4; $test5)

$options:=New object:C1471("algorithm"; "bcrypt"; "cost"; "10")
$password1:="nEWpaSS1"
$password2:="nEWpaSS2"
$REPEATEDPASS3:="nEWpaSS2"
$password4:="UsedPassWord"
addUsedPassword($password4)
START TRANSACTION:C239
/*$existing:=ds.UserPasswords.all().first()
$existingHash:=$existing.Password

C_OBJECT($obj)
$obj:=ds.UserPasswords.new()
$obj.Password:=Generate password hash($password1; $options)
$obj.Password:=Generate password hash($password2; $options)
*/

//Generate password hash($password; $options)
AJ_assert($test; addUsedPassword($password1); True:C214; " a new password"; "return true")
AJ_assert($test; addUsedPassword($password2); True:C214; "a new password "; "return true")
AJ_assert($test; addUsedPassword($REPEATEDPASS3); False:C215; "a repeated password "; "return false")

CANCEL TRANSACTION:C241
AJ_assert($test; addUsedPassword($password4); False:C215; "a previously used password"; "retuen false")

/*$test1:=addUsedPassword($password1)
$test2:=addUsedPassword($password2)
$test3:=addUsedPassword($password3)
$test4:=addUsedPassword($password4)
$test5:=addUsedPassword("testpassword1234!")*/

