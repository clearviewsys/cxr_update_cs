//%attributes = {}
// getYahooURLforCurrency (fromCurrency;ToCurrency)

C_TEXT:C284($url; $from; $to; $0)
$from:=$1
$to:=$2
$url:="http://finance.yahoo.com/currency/convert?from="+$from+"&to="+$to+"&amt=1&t=1y&submit=Convert"
$0:=$url
