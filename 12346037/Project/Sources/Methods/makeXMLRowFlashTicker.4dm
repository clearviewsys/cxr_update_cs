//%attributes = {}
C_TEXT:C284($0; $xml)
C_TEXT:C284($headline; $body; $detail; $color; $bgcolor; $buyRate; $sellRate)

$headline:=[Currencies:6]CurrencyCode:1+"-"+[Currencies:6]Name:2
$buyRate:="Buy:"+String:C10([Currencies:6]OurBuyRateLocal:7)
$sellRate:="Sell:"+String:C10([Currencies:6]OurSellRateLocal:8)
$headline:=$headline+Char:C90(13)+$buyRate+Char:C90(13)+$sellRate

$body:=enTag("text"; $headline)
$body:=$body+enTag("image"; "Flags/"+[Currencies:6]ISO4217:31+".JPG")
$body:=$body+enTag("targetIsURL"; "N")
$xml:=enTag("topic"; $body)
$0:=$xml