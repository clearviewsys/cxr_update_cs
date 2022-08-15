//%attributes = {}
// getTransactionTypeString (fromCurrency;toCurrency;isTransfer)

C_TEXT:C284($1; $2; $0)
C_TEXT:C284($from; $to; $type)
C_BOOLEAN:C305($isTransfer; $3)
$from:=$1
$to:=$2
$isTransfer:=$3

If ($isTransfer)
	$type:="Tr"
Else 
	Case of 
		: (($from="") & ($to=""))
			$type:=""
		: (($from=<>baseCurrency) & ($to=<>baseCurrency))  // transfer, or charge
			$type:="-"
		: (($from=<>baseCurrency) & ($to#<>baseCurrency))  // sell
			$type:="Sell"
		: (($from#<>baseCurrency) & ($to=<>baseCurrency))  // buy
			$type:="Buy"
		: (($from#<>baseCurrency) & ($to#<>baseCurrency))  // cross
			$type:="Cross"
		Else 
			$type:=""
	End case 
End if 

$0:=$type