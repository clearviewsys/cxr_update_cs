//%attributes = {}
// getTotalOrderForCurrencyByOrderID (orderId; curr) : real
// returns the sum of the order of a certain currency

C_REAL:C285($0)

C_TEXT:C284($orderID; $1; $curr; $2)

$orderID:=$1
$curr:=$2

QUERY:C277([OrderLines:96]; [OrderLines:96]orderID:2=$orderID; *)
QUERY:C277([OrderLines:96];  & ; [OrderLines:96]Curr:3=$curr)

$0:=Sum:C1([OrderLines:96]orderValue:14)
