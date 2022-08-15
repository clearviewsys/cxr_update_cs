//%attributes = {"shared":true}
// __UNIT_TEST
//by @Zoya
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("FJ_Trim"; Current method name:C684; "No Category")

AJ_assert($test; FJ_Trim(""); ""; "an empty string"; "return an empty string")
AJ_assert($test; FJ_Trim("  Hello"); "Hello"; "'  Hello'"; "return 'Hello' without the starting spaces")
AJ_assert($test; FJ_Trim("  Hello  "); "Hello"; "'  Hello  '"; "return 'Hello' without the rear spaces and leading spaces")
AJ_assert($test; FJ_Trim("  H e l l o  "); "H e l l o"; "'  H e l l o  '"; "return 'H e l l o' without the rear spaces and leading spaces")
AJ_assert($test; FJ_Trim("540  "); "540"; "'540  '"; "return '540' without the rear spaces")
AJ_assert($test; FJ_Trim("?-_0 ut ii"); "?-_0 ut ii"; "'?-_0 ut ii'"; "return '?-_0 ut ii'")

