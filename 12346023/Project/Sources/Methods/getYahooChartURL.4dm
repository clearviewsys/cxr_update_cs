//%attributes = {}
// getYahooChartURL( fromCurrency; toCurrency) -> URL

//return the address for a yahoo chart showing the ups and downs of the currency

C_TEXT:C284($str; $1; $2)

Case of 
	: (Count parameters:C259=1)
		$str:=$1
	: (Count parameters:C259=2)
		$str:=$1+$2
End case 
$0:="http://ichart.yahoo.com/z?s="+$str+"=X&z=m&t=3m"