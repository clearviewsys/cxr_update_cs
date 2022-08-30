//%attributes = {"shared":true}
// __UNIT_TEST
// @barclay
//Dec 2020
// #placeholder

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("POLI_getPaymentLiunk"; Current method name:C684; "API.POLiPay")

C_OBJECT:C1216($request; $return)
$request:=New object:C1471
$request.Amount:="1.75"
$request.MerchantReference:="TEST12345"

$return:=POLI_getPaymentLink($request)

AJ_assert($test; $return.success; True:C214; "Given POLiPayLink for making payment $1.75 with ref"; "TRUE: should return a link in format https://poli.com/xxxxx")


C_OBJECT:C1216($request; $return)
$request:=New object:C1471
$request.Amount:="1.75"
$request.MerchantReference:=""

$return:=POLI_getPaymentLink($request)

AJ_assert($test; $return.success; False:C215; "Given POLiPayLink for making payment  $1.75 no ref"; "FALSE: should fail b/c no merch reference")