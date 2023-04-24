//%attributes = {"shared":true}
// __UNIT_TEST
//@Zoya 18 Jun 2021

C_OBJECT:C1216($test; $existing)
$test:=AJ_UnitTest.new("checkUsedPassword"; Current method name:C684; "Validation")

C_OBJECT:C1216($options)
C_TEXT:C284($password1; $password2; $password3; $password4; $existingHash)
//C_BOOLEAN($test1; $test2; $test3; $test4; $test5)

$options:=New object:C1471("algorithm"; "bcrypt"; "cost"; "10")
$password1:="Password1"
$password2:="Password2"
$password3:="Password5"
$password4:="Password6"
$existing:=ds:C1482.UserPasswords.all().first()

//ALERT(String(ds.UserPasswords.all().count()))
$existingHash:=$existing.Password

CREATE RECORD:C68([UserPasswords:145])
$options:=New object:C1471("algorithm"; "bcrypt"; "cost"; "10")
[UserPasswords:145]Password:1:=Generate password hash:C1533(""; $options)
SAVE RECORD:C53([UserPasswords:145])

CREATE RECORD:C68([UserPasswords:145])
$options:=New object:C1471("algorithm"; "bcrypt"; "cost"; "10")
[UserPasswords:145]Password:1:=Generate password hash:C1533(" "; $options)
SAVE RECORD:C53([UserPasswords:145])


CREATE RECORD:C68([UserPasswords:145])
$options:=New object:C1471("algorithm"; "bcrypt"; "cost"; "10")
[UserPasswords:145]Password:1:=Generate password hash:C1533("thisPassword"; $options)
SAVE RECORD:C53([UserPasswords:145])

AJ_assert($test; checkUsedPassword("thisPassword"); True:C214; "thisPassword which was added before"; "return true")
AJ_assert($test; checkUsedPassword(""); True:C214; "an empty string which is added before"; " return true")
AJ_assert($test; checkUsedPassword(" "); True:C214; "a space which has been added before "; "return true")

AJ_assert($test; checkUsedPassword($password1); True:C214; ""; "return true")
AJ_assert($test; checkUsedPassword($password1); True:C214; ""; "return true")
AJ_assert($test; checkUsedPassword("iuiui8989"); False:C215; "iuiui8989 which wasn't added before"; "")

AJ_assert($test; checkUsedPassword("iuiui8989"); False:C215; ""; "")
AJ_assert($test; checkUsedPassword($password3); True:C214; ""; "return true")
AJ_assert($test; checkUsedPassword("Password6"); True:C214; ""; "return true")


/*$test1:=addUsedPassword($password1)
$test2:=addUsedPassword($password2)
$test3:=addUsedPassword($password3)
$test4:=addUsedPassword($password4)
$test5:=addUsedPassword("testpassword1234!")*/

