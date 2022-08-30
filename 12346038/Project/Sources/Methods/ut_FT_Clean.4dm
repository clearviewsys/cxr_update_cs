//%attributes = {"shared":true}
// __UNIT_TEST
//@Zoya
//@15 MAR 2021

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("FT_Clean"; Current method name:C684; "No Category")
AJ_assert($test; FT_Clean(""); ""; "an empty string"; "return an empty string")
AJ_assert($test; FT_Clean("hello world..."); "hello world"; "hello world..."; "return 'hello world'")
AJ_assert($test; FT_Clean("(?34, hello, 23+74-53 world)"); "?34, hello, 237453 world"; "(?34, hello, 23+74-53 world)"; "return '?34, hello, 237453 world'")
AJ_assert($test; FT_Clean("(?34, hello, 23+74-53 world)"; False:C215; True:C214); "?34 hello 237453 world"; "(?34, hello, 23+74-53 world)"; "return '?34 hello 237453 world'")
AJ_assert($test; FT_Clean("(   ?34, hello, 23+74-53 world   )"; True:C214; True:C214); "?34hello237453world"; "(   ?34, hello, 23+74-53 world   )"; "return '?34hello237453world'")
AJ_assert($test; FT_Clean("(...)"); ""; "(...)"; "return an empty String")


