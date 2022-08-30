//%attributes = {}


C_REAL:C285($1; $2; $0)
C_LONGINT:C283($i)
READ ONLY:C145([Invoices:5])

FIRST RECORD:C50([Invoices:5])
C_REAL:C285($avgRate; $prevAvg; $balance; $volumeCAD)

$balance:=$1
$prevAvg:=$2
$avgRate:=$2


C_REAL:C285($avgRate; $prevAvg; $balance; $volumeCAD; $buyRate)

For ($i; 1; Records in selection:C76([Invoices:5]))
	
	If ([Invoices:5]fromCurrency:3=[Currencies:6]CurrencyCode:1)  // Buy
		$buyRate:=([Invoices:5]ExchangeRate:21*[Invoices:5]PolicyRateSell:10)
		$volumeCAD:=($Balance*$prevAvg)+([Invoices:5]fromAmount:25*$buyRate)
		$balance:=$balance+[Invoices:5]fromAmount:25
		$avgRate:=$volumeCAD/$balance
		$prevAvg:=$avgRate  // now update the previous average
	End if 
	
	If ([Invoices:5]toCurrency:8=[Currencies:6]CurrencyCode:1)  // sell 
		$balance:=$balance-[Invoices:5]toAmount:26
	End if 
	
	NEXT RECORD:C51([Invoices:5])
End for 

$0:=$avgRate