//%attributes = {}
// fillCurrencyRateSheetArrays (all or favorites: bool)
C_BOOLEAN:C305($favoritesOnly)
$favoritesOnly:=$1

If ($favoritesOnly)
	QUERY:C277([Currencies:6]; [Currencies:6]isFavorite:45=True:C214)
Else 
	QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1#<>baseCurrency)
End if 

C_LONGINT:C283($n)
$n:=Records in selection:C76([Currencies:6])

ARRAY PICTURE:C279(aFlags; $n)
ARRAY TEXT:C222(aCurrencies; $n)
ARRAY LONGINT:C221(arrRowNo; $n)
ARRAY REAL:C219(aOurBuyRates; $n)
ARRAY REAL:C219(aSpotRates; $n)
ARRAY REAL:C219(aOurSellRates; $n)

ARRAY REAL:C219(aInvBuyRates; $n)
ARRAY REAL:C219(aInvSpotRates; $n)
ARRAY REAL:C219(aInvSellRates; $n)
ARRAY BOOLEAN:C223(arrIsHidden; $n)
ARRAY TEXT:C222(arrCountries; $n)
ARRAY TEXT:C222(arrCurrencyNames; $n)
ARRAY TEXT:C222(arrCountries; $n)

orderByCurrencies
SELECTION TO ARRAY:C260([Currencies:6]Name:2; arrCurrencyNames; [Currencies:6]Country:22; arrCountries; [Currencies:6]isHiddenOnXML:36; arrIsHidden; [Currencies:6]Flag:3; aFlags; [Currencies:6]CurrencyCode:1; aCurrencies; [Currencies:6]OurBuyRateLocal:7; aOurBuyRates; [Currencies:6]SpotRateLocal:17; aSpotRates; [Currencies:6]OurSellRateLocal:8; aOurSellRates; [Currencies:6]OurBuyRateInverse:25; aInvBuyRates; [Currencies:6]spotRateInverse:41; aInvSpotRates; [Currencies:6]OurSellRateInverse:26; aInvSellRates)
// [Currencies];"Entry"
//[Currencies]isHiddenOnWeb
