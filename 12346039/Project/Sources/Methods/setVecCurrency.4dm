//%attributes = {}
// setVecCurrency (Currency Code;forceRateChange)
// this method is used to mutate the value of the vecCurrency
C_TEXT:C284($1; $vCurrency)
C_BOOLEAN:C305($isForced; $2)
$vCurrency:=$1
Case of 
	: (Count parameters:C259=2)
		$isForced:=$2
End case 

handleVecCurrency($vCurrency; ->vCurrency; ->vCurrencyAlias; ->vBuyRate; ->vspotRate; ->vSellRate; ->vBuyRateInv; ->vSpotRateInv; ->vSellRateInv)
setFlagPicture(->vCurrencyFlag; $vCurrency)  // set the flag
vecCurrency{0}:=$vCurrency  // correct the lower/upper case of the entry
setExchangeRate(->vRate; ->vInverseRate; vReceivedOrPaid; vBuyRate; vSellRate; $isForced)

