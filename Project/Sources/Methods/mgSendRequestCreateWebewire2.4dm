//%attributes = {}

C_OBJECT:C1216($1; $webEwire)
C_OBJECT:C1216($2; $parameters)
C_OBJECT:C1216($3; $result)
C_TEXT:C284($4; $customerID)

C_TEXT:C284($0; $webEwireID)


$webEwire:=$1
$parameters:=$2
$result:=$3
$customerID:=$4


$webEwire.WebEwireID:=Replace string:C233($webEwire.WebEwireID; "WEB"; "MGS")

$webEwire.CustomerID:=$customerID
$webEwire.status:=5  // pending

If ($webEwire.paymentInfo=Null:C1517)
	$webEwire.paymentInfo:=New object:C1471
End if 

$webEwire.paymentInfo.invoiceID:=""  // easier to find later during Invoice creation than to look for null
$webEwire.paymentInfo.origin:="SOAP"

// keep original values used for SOAP call and result
$webEwire.paymentInfo.soap:=New object:C1471
$webEwire.paymentInfo.soap.result:=$result
$webEwire.paymentInfo.soap.passed:=$parameters
// --------------

$webEwire.toCountryCode:=mgCountryCode2CXR_CC(mgCountryID2CountryCode(Num:C11($parameters.TransferToCountry)))
$webEwire.toAmount:=Num:C11($result.result.TransferAmount)
$webEwire.toCCY:=mgCurrencyID2CurrencyCode(Num:C11($result.result.TransferCurrency))
$webEwire.fromCCY:=mgCurrencyID2CurrencyCode(Num:C11($parameters.TransferSendCurrency))

$webEwire.fromFee:=Num:C11($result.result.TransferTotalFeeAmount)
$webEwire.fromAmount:=$parameters.TransferSendAmount  //+$webEwire.fromFee  //3/12/22 IBBB added fee - @milan is this is problem ??


$webEwire.paymentInfo.result:=New object:C1471  // resulting JSON received from MoneyGram after transaction
$webEwire.paymentInfo.passedToMoneyGram:=New object:C1471  // data we sent to MoneyGram

// remap SOAP API properties back to Profix named properties

$webEwire.paymentInfo.passedToMoneyGram:=mgSendRequest2Profix($parameters)
$webEwire.paymentInfo.result:=mgSendRequest2ProfixResult($result)

$0:=$webEwire.WebEwireID