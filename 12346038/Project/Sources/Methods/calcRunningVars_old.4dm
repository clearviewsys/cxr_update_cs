//%attributes = {}
// calcRunningVars($openingBalance, $prevAvg; ->avgBuyRate;->avgHedged;->profit)
// this method is called from within the currency view form to calculate every detail of the transactions
// it calculates the avgBuy, avgSell,  Profit, etc..

C_REAL:C285($1; $2)
C_POINTER:C301($3; $4; $5; $6)


FIRST RECORD:C50([Registers:10])
C_REAL:C285($runningAvgBuy; $prevAvg; $balance; $volumeCAD; $buyRate; $sellRate; $profit; $breakEvenAvg)

$balance:=$1
$prevAvg:=$2
$runningAvgBuy:=$2


C_REAL:C285($runningAvgBuy; $prevAvg; $balance; $volumeCAD; $buyRate)
C_LONGINT:C283($i)
For ($i; 1; Records in selection:C76([Registers:10]))
	
	//If ([Registers]Currency=[Currencies]CurrencyCode)  ` Buy
	If ([Registers:10]Debit:8>0)  // Buy
		$buyRate:=[Registers:10]DebitLocal:23/[Registers:10]Debit:8  // this different from our Rate (it is normalized considering the fee)
		$volumeCAD:=($Balance*$prevAvg)+([Registers:10]DebitLocal:23)
		$balance:=$balance+[Registers:10]Debit:8
		$runningAvgBuy:=$volumeCAD/$balance
		$prevAvg:=$runningAvgBuy  // now update the previous average
	End if 
	
	//If ([Registers]Currency=[Currencies]CurrencyCode)  ` sell 
	If ([Registers:10]Credit:7>0)
		$balance:=$balance-[Registers:10]Credit:7
		//$sellRate:=([Invoices]PolicyRateBuy/[Invoices]ExchangeRate)
		$sellRate:=[Registers:10]CreditLocal:24/[Registers:10]Credit:7
		$profit:=$profit+([Registers:10]Credit:7*($sellRate-$runningAvgBuy))  // this the profit of this single transaction
	End if 
	
	$breakEvenAvg:=calcSafeDivide((($balance*$runningAvgBuy)-$profit); $balance)
	NEXT RECORD:C51([Registers:10])
End for 

$3->:=$runningAvgBuy
$4->:=$breakEvenAvg
$5->:=$profit