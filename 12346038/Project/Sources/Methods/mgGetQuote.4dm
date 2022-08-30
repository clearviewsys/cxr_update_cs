//%attributes = {}
// returns the status of transaction - receive transaction only
C_REAL:C285($1; $amount)
C_TEXT:C284($2; $sendCurrencyCode)
C_TEXT:C284($3; $sendToCountryCode)
C_TEXT:C284($4; $calcMode)  // QINC_FEE - send amount including fee
// QEX_FEE – send amount without fee
C_TEXT:C284($5; $promotionCode)
C_COLLECTION:C1488($countries)
C_OBJECT:C1216($0; $parameters; $result; $mgCredentials; $currencies)

$amount:=$1
$sendCurrencyCode:=$2
$sendToCountryCode:=$3
$promotionCode:=""
$calcMode:="QINC_FEE"  // assume "QINC_FEE"

If (Count parameters:C259>3)
	If ($4#"")
		$calcMode:=$4
	End if 
	If (Count parameters:C259>4)
		$promotionCode:=$5
	End if 
End if 

$mgCredentials:=mgGetCredentials

If ($mgCredentials#Null:C1517)
	
	If ($currencies=Null:C1517)
		$currencies:=mgGetCurrencies
	End if 
	
	If ($countries=Null:C1517)
		$countries:=mgGetCountryCodes
	End if 
	
	$parameters:=New object:C1471
	$parameters.Amount:=$amount
	$parameters.TransferSendCurrency:=mgCurrencyCode2CurrencyID($sendCurrencyCode; $currencies)
	$parameters.TransferToCountry:=mgCountryCode2CountryID($sendToCountryCode; $countries)
	$parameters.TransferCalcMode:=$calcMode
	If ($promotionCode#"")
		$parameters.PromotionCode:=$promotionCode
	End if 
	
	
	$result:=mgSOAP_RunMethod($mgCredentials; "GetDeliveryOptions"; $parameters)
	
	// uncomment for debugging
	// SET TEXT TO PASTEBOARD($result.response)
	
End if 

$0:=$result
