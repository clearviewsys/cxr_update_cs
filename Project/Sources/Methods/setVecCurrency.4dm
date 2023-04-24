//%attributes = {}
// setVecCurrency (Currency Code;forceRateChange)
// this method is used to mutate the value of the vecCurrency
C_TEXT:C284($1; $vCurrency)
C_BOOLEAN:C305($isForced; $2)

C_OBJECT:C1216($rule; $rules)
C_BOOLEAN:C305($isBuy)

$vCurrency:=$1
Case of 
	: (Count parameters:C259=2)
		$isForced:=$2
End case 

handleVecCurrency($vCurrency; ->vCurrency; ->vCurrencyAlias; ->vBuyRate; ->vspotRate; ->vSellRate; ->vBuyRateInv; ->vSpotRateInv; ->vSellRateInv)
setFlagPicture(->vCurrencyFlag; $vCurrency)  // set the flag
vecCurrency{0}:=$vCurrency  // correct the lower/upper case of the entry

// can we add a hook here for [rateRules]
If (getKeyValue("invoices.useRateRules"; "false")="true")
	
	$isBuy:=Choose:C955(vReceivedOrPaid="Received"; True:C214; False:C215)
	//$rules:=getTieredRule (<>baseCurrency;$vCurrency;vAmount;$isBuy;[Customers]GroupName;[Customers]CustomerID;vecPaymentMethod{vecPaymentMethod})
	$rules:=getTieredRule(<>baseCurrency; $vCurrency; vAmount; $isBuy; [Customers:3]GroupName:90; [Customers:3]CustomerID:1; vecPaymentMethod{vecPaymentMethod})
	
	If ($rules.length=1)
		$rule:=$rules.first()
		
		If ($isBuy)
			vRate:=vspotRate+$rule.buyMargin
			vInverseRate:=Round:C94(calcSafeDivide(1; vRate); [Currencies:6]RoundDigitInverse:28)
			vFeeLocal:=$rule.buyFee
		Else 
			vRate:=vspotRate+$rule.sellMargin
			vInverseRate:=Round:C94(calcSafeDivide(1; vRate); [Currencies:6]RoundDigitInverse:28)
			vFeeLocal:=$rule.sellFee
		End if 
	Else 
		setExchangeRate(->vRate; ->vInverseRate; vReceivedOrPaid; vBuyRate; vSellRate; $isForced)
	End if 
	
Else 
	setExchangeRate(->vRate; ->vInverseRate; vReceivedOrPaid; vBuyRate; vSellRate; $isForced)
End if 
