//%attributes = {}
C_OBJECT:C1216($1; $mgSendRequestResult)  // what we received as result from a call to SendRequest SOAP API method
C_OBJECT:C1216($0; $profixObj)

$mgSendRequestResult:=$1

$profixObj:=New object:C1471

$profixObj.receiveAmount:=$mgSendRequestResult.TransferAmount
$profixObj.receiveCurrency:=mgCurrencyID2CurrencyCode(OB Get:C1224($mgSendRequestResult; "TransferCurrency"; Is longint:K8:6))
$profixObj.rate:=$mgSendRequestResult.TransferExchangeRate
$profixObj.transactionStatus:=$mgSendRequestResult.TransferState
$profixObj.transactionDateTime:=$mgSendRequestResult.TransferSystemTransactionDate
$profixObj.sendFee:=$mgSendRequestResult.TransferTotalFeeAmount
$profixObj.sendAmount:=$mgSendRequestResult.TransferTotalSendAmount

$0:=$profixObj
