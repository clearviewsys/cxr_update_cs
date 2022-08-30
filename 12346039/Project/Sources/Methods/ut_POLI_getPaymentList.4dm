//%attributes = {"shared":true}
// __UNIT_TEST
// @barclay
// Dec 2020
// #placeholder

C_OBJECT:C1216($test; $return)
$test:=AJ_UnitTest.new("POLI_getPaymentStatus"; Current method name:C684; "API.POLiPay")

$return:=POLI_getPaymentList

AJ_assert($test; $return.success; True:C214; "Get a list of links for the merchant"; "TRUE: should return a list of links")


