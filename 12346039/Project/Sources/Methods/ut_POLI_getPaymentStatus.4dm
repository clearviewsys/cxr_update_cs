//%attributes = {"shared":true}
// __UNIT_TEST
// @barclay
// Dec 2020
// #placeholder

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("POLI_getPaymentStatus"; Current method name:C684; "API.POLiPay")
C_TEXT:C284($link)

//-- do we need to turn test mode on?? ----

C_OBJECT:C1216($request; $return)
$request:=New object:C1471
$request.Amount:="1.75"
$request.MerchantReference:="TEST12345"

$return:=POLI_getPaymentLink($request)

AJ_assert($test; $return.success; True:C214; "Given POLiPayLink for making payment $1.75 with ref"; "TRUE: should return a link in format https://poli.com/xxxxx")

If ($return.success)
	$link:=$return.statusText
	
	$return:=POLI_getPaymentStatus($link)
End if 

AJ_assert($test; $return.success; True:C214; "Given an existing POLiPayLink"; "TRUE: should return status for the given link")


