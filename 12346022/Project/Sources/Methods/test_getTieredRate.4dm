//%attributes = {}
C_TEXT:C284($fromCurrency; $toCurrency; $customerType; $customerID)
C_REAL:C285($amount)
C_BOOLEAN:C305($isBuy)
C_OBJECT:C1216($o)

//________________________________ buy USD  1K

$fromCurrency:="USD"
$toCurrency:="NZD"
$amount:=1000
$isBuy:=True:C214
$customerType:=""
$customerID:=""

$o:=getTieredRate($fromCurrency; $toCurrency; $amount; $isBuy; $customerType; $customerID)
$o.testString:="Buy 1K usd"
myAlert(JSON Stringify:C1217($o))

//________________________________ buy CAD 1K , VIP only

$fromCurrency:="CAD"
$toCurrency:="NZD"
$amount:=1000
$isBuy:=True:C214
$customerType:="VIP"
$customerID:=""

$o:=getTieredRate($fromCurrency; $toCurrency; $amount; $isBuy; $customerType; $customerID)
$o.testString:="Buy 1K CAD VIP ONLY"

myAlert(JSON Stringify:C1217($o))

//________________________________ sell CAD 1K, VIP Only

$fromCurrency:="CAD"
$toCurrency:="NZD"
$amount:=1000
$isBuy:=False:C215
$customerType:="VIP"
$customerID:=""

$o:=getTieredRate($fromCurrency; $toCurrency; $amount; $isBuy; $customerType; $customerID)
$o.testString:="SELL 1K CAD VIP ONLY"

myAlert(JSON Stringify:C1217($o))

//________________________________ sell CAD over 11K, VIP Only
$fromCurrency:="CAD"
$toCurrency:="NZD"
$amount:=11111
$isBuy:=False:C215
$customerType:="VIP"
$customerID:=""

$o:=getTieredRate($fromCurrency; $toCurrency; $amount; $isBuy; $customerType; $customerID)
$o.testString:="SELL 11K CAD VIP ONLY"

myAlert(JSON Stringify:C1217($o))

//________________________________ sell CAD over 11K, VIP Only
$fromCurrency:="CAD"
$toCurrency:="NZD"
$amount:=11111
$isBuy:=False:C215
$customerType:="VIP"
$customerID:=""

$o:=getTieredRate($fromCurrency; $toCurrency; $amount; $isBuy; $customerType; $customerID)
$o.testString:="SELL 11K CAD VIP ONLY"

myAlert(JSON Stringify:C1217($o))

//________________________________ sell CAD over 11K, for 1 customer
$fromCurrency:="usd"
$toCurrency:="NZD"
$amount:=200
$isBuy:=False:C215
$customerType:=""
$customerID:="ttcus1029221"

$o:=getTieredRate($fromCurrency; $toCurrency; $amount; $isBuy; $customerType; $customerID)
$o.testString:="SELL $200 usd for customer"

myAlert(JSON Stringify:C1217($o))