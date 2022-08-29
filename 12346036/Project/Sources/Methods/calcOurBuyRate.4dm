//%attributes = {}
// calcOurBuyRate(MarketBuy;offsetBuy;pctBuy) -> real

// this method calculate our Buy Rate

// OurPrice := ((Market*(1+pct%))


C_REAL:C285($1; $2; $3; $0)
C_REAL:C285($offset; $percent; $market)
$market:=$1
$offset:=$2
$percent:=$3
$0:=($market*(1-($percent/100)))-$offset
