//%attributes = {}


C_TEXT:C284($1; $from)
C_TEXT:C284($2; $to)

C_OBJECT:C1216($0; $o)
C_OBJECT:C1216($entity)

$from:=$1
$to:=$2

$o:=New object:C1471

$entity:=ds:C1482.Currencies.query("ISO4217 ==:1 AND toISO4217 == :2"; $from; $to)

Case of 
	: ($entity.length>0)
		$o.SpotRateLocal:=$entity.first().SpotRateLocal
		$o.OurBuyRateLocal:=$entity.first().OurBuyRateLocal
		$o.OurBuyRateInverse:=$entity.first().OurBuyRateInverse
		$o.OurSellRateInverse:=$entity.first().OurSellRateInverse
		$o.OurSellRateLocal:=$entity.first().OurSellRateLocal
		
	: ($from=$to)
		$o.SpotRateLocal:=1
		$o.OurBuyRateLocal:=1
		$o.OurBuyRateInverse:=1
		$o.OurSellRateInverse:=1
		$o.OurSellRateLocal:=1
		
	Else 
		$o.SpotRateLocal:=0
		$o.OurBuyRateLocal:=0
		$o.OurBuyRateInverse:=0
		$o.OurSellRateInverse:=0
		$o.OurSellRateLocal:=0
End case 

$0:=$o