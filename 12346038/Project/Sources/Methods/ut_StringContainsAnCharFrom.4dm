//%attributes = {"shared":true}
// __UNIT_TEST
// unit testing for test_StringContainsAnCharFrom
// @Zoya

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("stringContainsAnyCharFrom"; Current method name:C684; "No Category")

//c_Collection ($testData)

AJ_assert($test; stringContainsAnyCharFrom("alllowercase"; "E"; True:C214); False:C215; "the string 'alllowercase' to find in case-sensative mode 'E' in it "; "return False")
AJ_assert($test; stringContainsAnyCharFrom("alllowercase"; "E"); True:C214; "the string 'alllowercase' to find 'E' in it "; "return True")
AJ_assert($test; stringContainsAnyCharFrom("alllowercase"; "e"); True:C214; "the string 'alllowercase' to find 'e' in it "; "return True")

AJ_assert($test; stringContainsAnyCharFrom("alllowercase"; "LOOKFORlower"; True:C214); True:C214; "the string 'alllowercase' to find in case-sensative mode 'LOOKFORlower' in it "; "return False")

AJ_assert($test; stringContainsAnyCharFrom("ALLCAPS"; "a"; True:C214); False:C215; "the string'ALLCAPS' to find in case-sensative mode 'a' in it"; "return False")
AJ_assert($test; stringContainsAnyCharFrom("ALLCAPS"; "aLL"; True:C214); True:C214; "the string'ALLCAPS' to find in case-sensative mode 'aLL' in it"; "return True")

AJ_assert($test; stringContainsAnyCharFrom("hello"; "h"; False:C215); True:C214; "hello to find in case-insensative mode 'h' in it"; "False")
AJ_assert($test; stringContainsAnyCharFrom("hello"; "H"; False:C215); True:C214; "hello to find in case-insensative mode 'H' in it"; "False")

AJ_assert($test; stringContainsAnyCharFrom("hello"; "."); False:C215; "hello to find . in it"; "False")

AJ_assert($test; stringContainsAnyCharFrom("okidoki2!@"; "!@#$%^&*()_+"); True:C214; "okidoki2!@ to find '!@#$0%^ & *()_+' in it"; "True")
AJ_assert($test; stringContainsAnyCharFrom(" "; " "); True:C214; "a space character to find space character"; "True")
AJ_assert($test; stringContainsAnyCharFrom(" "; ""); False:C215; "a space character to find no char"; "False")
AJ_assert($test; stringContainsAnyCharFrom(""; " "); False:C215; "an empty string to find Space char in it"; "False")
AJ_assert($test; stringContainsAnyCharFrom(""; ""); False:C215; "an empty string to find no char"; "False")
AJ_assert($test; stringContainsAnyCharFrom("3ut"; String:C10(5-2)); True:C214; "2222 to find String(4-2) in it"; "True")


/*C_TEXT($source; $charString)
C_BOOLEAN($test; $expected)


$source:="tiran"
$charString:="12345"
$expected:=False
$test:=stringContainsAnyCharFrom($source; $charString)
ASSERT($test=$expected; $source+" contains any char from "+$charString+" was expected to be "+String($expected))

$source:="tiran"
$charString:="1234i"
$expected:=True
$test:=stringContainsAnyCharFrom($source; $charString)
ASSERT($test=$expected; $source+" contains any char from "+$charString+" was expected to be "+String($expected))

$source:="okidoki2"
$charString:="1234567890"
$expected:=True
$test:=stringContainsAnyCharFrom($source; $charString)
ASSERT($test=$expected; $source+" contains any char from "+$charString+" was expected to be "+String($expected))

$source:="1234"
$charString:="01"
$expected:=True
$test:=stringContainsAnyCharFrom($source; $charString)
ASSERT($test=$expected; $source+" contains any char from "+$charString+" was expected to be "+String($expected))

$source:="1234"
$charString:="abcdefghijklmnopqrstuvwxyz"
$expected:=False
$test:=stringContainsAnyCharFrom($source; $charString)
ASSERT($test=$expected; $source+" contains any char from "+$charString+" was expected to be "+String($expected))

$source:=""
$charString:="abcdefghijklmnopqrstuvwxyz"
$expected:=False
$test:=stringContainsAnyCharFrom($source; $charString)
ASSERT($test=$expected; $source+" contains any char from "+$charString+" was expected to be "+String($expected))

$source:="okidoki"
$charString:="!@#$%^&*()_+"
$expected:=False
$test:=stringContainsAnyCharFrom($source; $charString)
ASSERT($test=$expected; $source+" contains any char from "+$charString+" was expected to be "+String($expected))

$source:="okidoki2!@"
$charString:="!@#$%^&*()_+"
$expected:=True
$test:=stringContainsAnyCharFrom($source; $charString)
ASSERT($test=$expected; $source+" contains any char from "+$charString+" was expected to be "+String($expected))
*/