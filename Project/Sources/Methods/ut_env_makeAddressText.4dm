//%attributes = {"shared":true}
// __UNIT_TEST
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("env_makeAddressText"; Current method name:C684; "Modules.Addresses")

AJ_assert($test; env_makeAddressText("123 St."; "Vancouver"; "BC"; "1A1A1A"; "CA"); "123 St."+CRLF+"Vancouver, BC, 1A1A1A, CA"; "123 St.; Vancouver; BC; 1A1A1A; CA"; "123 St.Vancouver, BC, 1A1A1A, CA")
AJ_assert($test; env_makeAddressText(" "; " "; " "; " "; " "); " "+CRLF+" ,  ,  ,  "; "all spaces"; " return all spaces")