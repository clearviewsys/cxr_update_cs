//%attributes = {}
// gets SendRequest SOAP method information from API based on delivery option selected


//TransferSendAmount = fromAmount before fromFee
//TransferCurrency = toCCY
//Country = toCountry
//DeliveryOptionCode = MG code ie. WILL_CALL...
// NOTE: FROM data must be from agent id

C_OBJECT:C1216($1; $deliveryOption; $getMethodInfoParams)
C_OBJECT:C1216($0)

$deliveryOption:=$1

$getMethodInfoParams:=New object:C1471
$getMethodInfoParams.TransferSendAmount:=$deliveryOption.TransferSendAmount
$getMethodInfoParams.TransferCurrency:=$deliveryOption.TransferCurrency
$getMethodInfoParams.TransferSendCurrency:=$deliveryOption.TransferSendCurrency
$getMethodInfoParams.TransferToCountry:=$deliveryOption.Country
$getMethodInfoParams.DeliveryOptionCode:=$deliveryOption.DeliveryOptionCode

$0:=mgSOAP_GetMethodInfo("SendRequest"; $getMethodInfoParams)
