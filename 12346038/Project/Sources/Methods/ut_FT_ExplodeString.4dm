//%attributes = {"shared":true}
// _UNIT_TEST
//@Zoya - 18 Jun 2021
C_OBJECT:C1216($test)


/*

$test:=AJ_UnitTest.new("FT_ExplodeString"; Current method name; "No Category")

FT_ExplodeString("Hello, 4D, How can I help you, Developer?"; ","; ->$arrTokens)
AJ_assert($test; $arrTokens{1}; "Hello"; "Hello, 4D, How can I help you, Developer? with separator ,"; "create array item 1: Hello")
AJ_assert($test; $arrTokens{3}; " How can I help you"; "Hello, 4D, How can I help you, Developer? with separator ,"; "create array item 3: How can I help you")

FT_ExplodeString("Hello"; "!"; ->arrTokens1)
AJ_assert($test; arrTokens1{1}; "Hello"; "Hello with separator !"; "create array item 1: Hello")

FT_ExplodeString("Hello"; "m"; ->arrTokens10)
AJ_assert($test; arrTokens10{1}; "Hello"; "Hello with separator m"; "create array item 1: Hello")

FT_ExplodeString(""; ","; ->arrTokens2)
AJ_assert($test; arrTokens2=Null; True; "empty string with separator ,"; "create a null array ")

FT_ExplodeString(",,,,"; ","; ->arrTokens3)
AJ_assert($test; arrTokens3{1}; ""; ",,,, with separtor ,"; "create an empty array")

FT_ExplodeString(""; "whatever"; ->arrTokens4)
AJ_assert($test; arrTokens2=Null; True; "an emapty string with whatever separator"; "create a null array")

FT_ExplodeString("Hello"; "e"; ->arrTokens5)
AJ_assert($test; arrTokens5{2}; "llo"; "Hello with Separator e"; "return llo")

FT_ExplodeString("t h i s i s d o n e"; " "; ->arrTokens6)
AJ_assert($test; arrTokens6{7}; "d"; "t h i s i s d o n e with separtor space"; "create an array wth item 7: d")

*/