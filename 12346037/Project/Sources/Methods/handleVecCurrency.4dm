//%attributes = {}
// handleVecCurrency (currencyAlias;->currencyISOCode;->currencyCode;->buyRate;->spotRate;->sellRate;->buyInv;->spotInv;->sellInv)
C_TEXT:C284($1)
C_POINTER:C301($2; $3; $4; $5; $6; $7; $8; $9)

If ($1=<>baseCurrency)
	$2->:=<>baseCurrency
	$3->:=<>baseCurrency
	$4->:=1
	$5->:=1
	$6->:=1
	$7->:=1
	$8->:=1
	$9->:=1
	
Else 
	READ ONLY:C145([Currencies:6])
	QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=$1)
	If (Records in selection:C76([Currencies:6])>=1)
		$2->:=[Currencies:6]ISO4217:31
		$3->:=[Currencies:6]CurrencyCode:1
		$4->:=[Currencies:6]OurBuyRateLocal:7
		$5->:=[Currencies:6]SpotRateLocal:17
		$6->:=[Currencies:6]OurSellRateLocal:8
		$7->:=[Currencies:6]OurBuyRateInverse:25
		$8->:=[Currencies:6]spotRateInverse:41
		$9->:=[Currencies:6]OurSellRateInverse:26
	Else 
		BEEP:C151
		$2->:="N/A"
		$3->:="N/A"
		$3->:=0
		$4->:=0
		$5->:=0
		$6->:=0
		$7->:=0
		$8->:=0
		$9->:=0
	End if 
End if 