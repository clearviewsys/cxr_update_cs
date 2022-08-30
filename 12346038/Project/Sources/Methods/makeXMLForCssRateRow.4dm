//%attributes = {}
C_TEXT:C284($0; $xml)
C_TEXT:C284($isFlagged; $shopifyID; $flagURL; $ISO; $name; $weBuy; $weSell; $invBuy; $invSell; $body; $rateRow; $rate; $country)
C_TEXT:C284($extension; <>flagExtension)

If ([Currencies:6]isOnFirstPage:49)
	$isFlagged:=enTag("ISFLAGGED"; "**")  // favorites will be on the first page
Else 
	$isFlagged:=enTag("ISFLAGGED"; "*")
End if 

If (<>flagExtension="")
	$extension:="JPG"
Else 
	$extension:=<>flagExtension
End if 

$flagURL:=enTag("FLAGURL"; "flags/"+[Currencies:6]ISO4217:31+"."+$extension)
$ISO:=enTag("ISO"; [Currencies:6]CurrencyCode:1)
$name:=enTag("NAME"; [Currencies:6]Name:2)
$country:=enTag("COUNTRY"; [Currencies:6]Country:22)
$shopifyID:=enTag("ID"; [Currencies:6]shopifyID:64)
C_REAL:C285($coeff; $coeffInv)
$coeff:=[Currencies:6]publishCoefficient:66
$coeffInv:=calcSafeDivide(1; $coeff)
If ($coeff=0)
	$coeff:=1
	$coeffInv:=1
End if 
C_TEXT:C284($str)
$str:=[Currencies:6]publishText:67
If ([Currencies:6]doPublishInversedRates:65)
	$weBuy:=enTag("WEBUY"; String:C10($coeffInv*[Currencies:6]OurBuyRateInverse:25; "|Currencies")+$str)
	$weSell:=enTag("WESELL"; String:C10($coeffInv*[Currencies:6]OurSellRateInverse:26; "|Currencies")+$str)
	$invBuy:=enTag("INVBUY"; String:C10($coeff*[Currencies:6]OurBuyRateLocal:7; "|Currencies")+$str)
	$invSell:=enTag("INVSELL"; String:C10($coeff*[Currencies:6]OurSellRateLocal:8; "|Currencies")+$str)
Else 
	$weBuy:=enTag("WEBUY"; String:C10($coeff*[Currencies:6]OurBuyRateLocal:7; "|Currencies")+$str)
	$weSell:=enTag("WESELL"; String:C10($coeff*[Currencies:6]OurSellRateLocal:8; "|Currencies")+$str)
	$invBuy:=enTag("INVBUY"; String:C10($coeffInv*[Currencies:6]OurBuyRateInverse:25; "|Currencies")+$str)
	$invSell:=enTag("INVSELL"; String:C10($coeffInv*[Currencies:6]OurSellRateInverse:26; "|Currencies")+$str)
End if 

$body:=$isFlagged+$flagURL+$ISO+$name+$country+$shopifyID+$weBuy+$weSell+$invBuy+$invSell
$rate:=enTag("RATE"; CRLF+$body)
$xml:=$rate
$0:=$xml
