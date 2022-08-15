//%attributes = {"shared":true}
// __UNIT_TEST
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("getBranch4DWebServerURL"; Current method name:C684; "GET")

AJ_assert($test; getBranch4DWebServerURL("543UY"); "localhost:8080"; "543UY"; "return localhost:8080")
AJ_assert($test; getBranch4DWebServerURL("5"); "localhost:8080"; "5"; "return localhost:8080")
AJ_assert($test; getBranch4DWebServerURL("QS"); ""; "QS"; "return nothing")
AJ_assert($test; getBranch4DWebServerURL("TEST"); "test"; "TEST"; "return test")
AJ_assert($test; getBranch4DWebServerURL("TQ"); ""; "TQ"; "return nothing")
