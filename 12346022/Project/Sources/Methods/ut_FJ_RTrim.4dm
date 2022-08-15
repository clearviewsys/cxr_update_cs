//%attributes = {"shared":true}
// __UNIT_TEST
//@Zoya 
//@ 07 Mar 2021
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("FJ_RTrim"; Current method name:C684; "No Category")

AJ_assert($test; FJ_RTrim(""); ""; "an empty String"; "return an empty String")
AJ_assert($test; FJ_RTrim("  Hello"); "  Hello"; "'  Hello'"; "return 'Hello' with the starting spaces")
AJ_assert($test; FJ_RTrim("  Hello  "); "  Hello"; "'  Hello  '"; "return 'Hello' without the ending spaces keeping starting spaces")
AJ_assert($test; FJ_RTrim("  H e l l o  "); "  H e l l o"; "'  H e l l o  '"; "return '  H e l l o' without the ending spaces keeping starting spaces")
AJ_assert($test; FJ_RTrim("540  "); "540"; "'540  '"; "return '540' without the ending spaces")
AJ_assert($test; FJ_RTrim("?-_0 ut ii"); "?-_0 ut ii"; "'?-_0 ut ii'"; "return '?-_0 ut ii'")
