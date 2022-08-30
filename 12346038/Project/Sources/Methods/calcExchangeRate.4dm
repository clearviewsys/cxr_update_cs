//%attributes = {}
// calcExchangeRate (fromCurrency;toCurrency) -> real:rate


C_TEXT:C284($1; $2)
C_REAL:C285($0)
C_REAL:C285($fromRate; $toRate)

QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=$1)  // load the first currency

$fromRate:=[Currencies:6]SpotRateLocal:17
QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=$2)  // load the second currency

$toRate:=[Currencies:6]SpotRateLocal:17
$0:=Round:C94($fromRate/$toRate; 5)