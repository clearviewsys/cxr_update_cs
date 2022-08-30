//Self->:=Uppercase(Self->)
//GET PICTURE FROM LIBRARY("flag_"+Self->;Logo)
//If (readCurrencyCodes (->[Currencies]CurrencyCode;->[Currencies]Country;->[Currencies]Name;Self))
//handleAutoUpdateRates 
//End if 

//pickFlags (Self)
//
//If (Form event=On Data Change )
//  `[Currencies]toISO4217:=[Flags]CurrencyCode
//If ([Currencies]toISO4217#◊baseCurrency)
//[Currencies]CurrencyCode:=[Currencies]ISO4217+"->"+[Currencies]toISO4217
//[Currencies]isDisplayOnly:=True
//Else 
//[Currencies]CurrencyCode:=[Currencies]ISO4217
//End if 
//manuallyUpdateSpotRate 
//End if 
handleISOField(Self:C308)