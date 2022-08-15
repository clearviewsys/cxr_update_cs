//%attributes = {}
C_TEXT:C284($0; $xml)
C_TEXT:C284($headline; $body; $detail; $color; $bgcolor; $buyRate; $sellRate)
$color:="0xFFFFFF"
$bgColor:="0x888888"
$headline:=Substring:C12([Currencies:6]CurrencyCode:1+"                "; 1; 10)
$buyRate:=Substring:C12(String:C10([Currencies:6]OurBuyRateLocal:7)+"                 "; 1; 8)
$sellRate:=Substring:C12(String:C10([Currencies:6]OurSellRateLocal:8)+"                 "; 1; 8)
$headline:=$headline+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+$buyRate+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+$sellRate

$detail:="Currency :"+[Currencies:6]CurrencyCode:1+Char:C90(13)
$detail:=$detail+[Currencies:6]Country:22+" ("+[Currencies:6]Name:2+")"+Char:C90(13)
$detail:=$detail+"We buy :"+String:C10([Currencies:6]OurBuyRateLocal:7; "|Rates")+" "+<>baseCurrency+Char:C90(13)
$detail:=$detail+"We Sell :"+String:C10([Currencies:6]OurSellRateLocal:8; "|Rates")+" "+<>baseCurrency+Char:C90(13)
$detail:=$detail+"Inverse Buy :"+String:C10([Currencies:6]OurBuyRateInverse:25; "|Rates")+" "+[Currencies:6]toISO4217:32+Char:C90(13)
$detail:=$detail+"Inverse Sell :"+String:C10([Currencies:6]OurSellRateInverse:26; "|Rates")+" "+[Currencies:6]toISO4217:32+Char:C90(13)

$body:=enTag("name"; $headline)
$body:=$body+enTag("textColor"; $color)+enTag("BGColor"; $bgColor)+enTag("tDate"; String:C10([Currencies:6]MarketUpdateDate:18))
// Modified by: Tiran Behrouz (3/22/13)

$body:=$body+enTag("dataRow"; $detail)
$xml:=enTag("data"; $body)
$0:=$xml