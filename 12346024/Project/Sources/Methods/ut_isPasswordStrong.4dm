//%attributes = {"shared":true}
// __UNIT_TEST
// by @Zoya - June 2021
C_OBJECT:C1216($test)


$test:=AJ_UnitTest.new("isPasswordStrong"; Current method name:C684; "Validation")
AJ_assert($test; isPasswordStrong("1234"; ->errorText); False:C215; "1234"; "return false")
AJ_assert($test; isPasswordStrong(" "; ->errorText); False:C215; " "; "return false")
AJ_assert($test; isPasswordStrong("@alllowercase123"; ->errorText); True:C214; "alllowercase123"; "return true")
AJ_assert($test; isPasswordStrong("%ALLCAPS1"; ->errorText); False:C215; "%ALLCAPS1"; "return false")
AJ_assert($test; isPasswordStrong("8Charss*"; ->errorText); False:C215; "8Charss*"; "return False")
AJ_assert($test; isPasswordStrong("_9Charsss"; ->errorText); True:C214; "_9Charsss"; "return True")
AJ_assert($test; isPasswordStrong("only10AlphaNum"; ->errorText); False:C215; "only10AlphaNum"; "return False")

