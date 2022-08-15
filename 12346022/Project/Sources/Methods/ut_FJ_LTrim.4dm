//%attributes = {"shared":true}
// __UNIT_TEST
//@Zoya 
//@ 07 Mar 2021
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("FJ_LTrim"; Current method name:C684; "No Category")

AJ_assert($test; FJ_LTrim(""); ""; "an empty String"; "return an empty String")
AJ_assert($test; FJ_LTrim("  Hello"); "Hello"; "'  Hello'"; "return 'Hello' without the starting spaces")
AJ_assert($test; FJ_LTrim("  540  "); "540  "; "'  540  '"; "return '540' without the leading spaces keeping rear spaces")
AJ_assert($test; FJ_LTrim("  H e l l o  "); "H e l l o  "; "'  H e l l o  '"; "return '  H e l l o' without the leading spaces keeping rear spaces")
AJ_assert($test; FJ_LTrim("Hello  "); "Hello  "; "'Hello  '"; "return 'Hello' keeping the rear spaces")
AJ_assert($test; FJ_LTrim("?-_0 ut ii"); "?-_0 ut ii"; "'?-_0 ut ii'"; "return '?-_0 ut ii'")
