//%attributes = {"shared":true}
//Unit test @Zoya
//12 Jan 2020

// __UNIT_TEST

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("UTIL_isValidEmail"; Current method name:C684; "Validation")

//$tPattern:="(?i)^([A-Z0-9._%+-]+)@(?:[A-Z0-9_-]+\\.)+([A-Z]{2,4})$(.*)"

AJ_assert($test; UTIL_isValidEmail("z@y.c"); False:C215; "z@y.c"; "return False")
AJ_assert($test; UTIL_isValidEmail("#@yahoo.com"); False:C215; "#@yahoo.com"; "return False")
AJ_assert($test; UTIL_isValidEmail("_@yahoo.com"); True:C214; "_@yahoo.com"; "?????return True")
AJ_assert($test; UTIL_isValidEmail("hello@yahoo.c"); False:C215; "hello@yahoo.c"; "return False")
AJ_assert($test; UTIL_isValidEmail("hello@t.ca"); True:C214; "hello@t.ca"; "return True")
AJ_assert($test; UTIL_isValidEmail("zoya_Salehi.ca"); False:C215; "zoya_Salehi.ca"; "return False")
AJ_assert($test; UTIL_isValidEmail("+@gmail.ca"); True:C214; "+@gmail.ca"; "return True??????")
AJ_assert($test; UTIL_isValidEmail("HellO@a\\.ca"); False:C215; "HellO@a\\.ca"; "return False")
AJ_assert($test; UTIL_isValidEmail("Hel@lO@yahoo.ca"); False:C215; "Hel@lO@yahoo.ca"; "return False")
AJ_assert($test; UTIL_isValidEmail("com.yahoo@zoyahello@yahoo.com"); False:C215; "com.yahoo@zoyahello@yahoo.com"; "return False")
AJ_assert($test; UTIL_isValidEmail("com.yahoo@zoya.com"); True:C214; "com.yahoo@zoya.com"; "return True")
AJ_assert($test; UTIL_isValidEmail("com.yahoo@zoy2a.com.ca"); True:C214; "com.yahoo@zoy2a.com.ca"; "return true")  // there is no problem with this one
AJ_assert($test; UTIL_isValidEmail("com.yahoo@zoy2a.6com"); False:C215; "com.yahoo@zoy2a.6com"; "return False")
AJ_assert($test; UTIL_isValidEmail("com.yahoo@zoya.COM"); True:C214; "com.yahoo@zoya.COM"; "return True")

AJ_assert($test; UTIL_isValidEmail("com.yahoo@zoy2a.2com"); False:C215; "com.yahoo@zoy2a.2com"; "return False")









