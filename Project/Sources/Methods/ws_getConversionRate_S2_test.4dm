//%attributes = {}
//author: Amir
//19th November 2019
//test method for ws_REST_getConversionRate which uses CXRate cloud service
C_LONGINT:C283($error; 0)
C_REAL:C285($rate)
C_TEXT:C284($fromCurrency; $toCurrency)

$rate:=-1
//bad currency request
$fromCurrency:="USD"
$toCurrency:="DDD"
$error:=ws_getConversionRate_S2($fromCurrency; $toCurrency; ->$rate)
ASSERT:C1129($error=1; "Expected error")
ASSERT:C1129($rate=-1; "Expected rate to not have proper value")

//correct request
$fromCurrency:="USD"
$toCurrency:="CAD"
$error:=ws_getConversionRate_S2($fromCurrency; $toCurrency; ->$rate)
ASSERT:C1129($error=0; "Expected no error")
ASSERT:C1129($rate>0; "Expected positive value for rate")