checkInit
checkGreaterThan(->[Currencies:6]ForcedMarketRate:14; "Manual Market Rate"; 0)


If (isValidationConfirmed)
	OBJECT SET ENABLED:C1123(Self:C308->; False:C215)
	[Currencies:6]SpotRateLocal:17:=[Currencies:6]ForcedMarketRate:14
	setCurrencyRates
	//_O_ENABLE BUTTON(Self->)
	OBJECT SET ENABLED:C1123(Self:C308->; True:C214)
	
End if 