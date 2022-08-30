//%attributes = {}
//calcRunningVars (0;0;0;->vRunningAvgBuy;->vBreakEvenAvg;->vSalesProfitInCAD;->volumeBoughtCAD;->volumeSoldCAD;->vRunningAvgSell;->vCostOfGoodsSoldCAD)
// this method is called from within the currency view form to calculate every detail of the transactions
// it calculates the avgBuy, avgSell,  Profit, etc..

C_REAL:C285($1; $2; $3)
C_POINTER:C301($4; $5; $6; $7; $8; $9; $10)

C_REAL:C285($profit; $sumProfitBuy; $sumProfitSell; $profitBuy; $profitSell; $breakEvenAvg)
C_REAL:C285($InventoryBalance; $rate)
C_REAL:C285($buyInventory; $runningAvgBuy; $prevRunningAvgBuy; $volumeBuyCAD)
C_REAL:C285($sellInventory; $runningAvgSell; $prevRunningAvgSell; $volumeSellCAD)
C_REAL:C285($buyAmount; $sellAmount; $buyAmountCAD; $sellAmountCAD; $sumBuyAmountCAD; $sumSellAmountCAD)
C_REAL:C285($buyInventoryOld; $sellInventoryOld)
C_REAL:C285($costOfGoodsSold; $costOfGoodsBought)
C_TEXT:C284($currency)
C_LONGINT:C283($i)

FIRST RECORD:C50([Registers:10])
$currency:=[Registers:10]Currency:19

$InventoryBalance:=$1

$prevRunningAvgBuy:=$2
$runningAvgBuy:=$2

$prevRunningAvgSell:=$3
$runningAvgSell:=$3

For ($i; 1; Records in selection:C76([Registers:10]))
	$buyAmount:=[Registers:10]Debit:8
	$sellAmount:=[Registers:10]Credit:7
	$rate:=[Registers:10]OurRate:25
	
	$buyAmountCAD:=$BuyAmount*$rate  // WE DO NOT USE [Registers]DebitLocal because the fee must not be included in the calculations
	$sellAmountCAD:=$SellAmount*$rate
	$sumBuyAmountCAD:=$sumBuyAmountCAD+$buyAmountCAD  // cumulative sum
	$sumSellAmountCAD:=$sumSellAmountCAD+$sellAmountCAD  //
	$buyInventoryOld:=$buyInventory
	$sellInventoryOld:=$sellInventory
	
	If ($buyAmount>0)  // Buy
		$volumeBuyCAD:=($InventoryBalance*$prevRunningAvgBuy)+$buyAmountCAD
		$buyInventory:=$buyInventory+$buyAmount
		If ($sellInventoryOld>0)
			$profitBuy:=(calcMin($sellInventoryOld; $buyAmount)*($runningAvgSell-$rate))  // this the profit of this single transaction
		Else 
			$profitBuy:=0
		End if 
		$profitSell:=0
	End if 
	
	
	If ($sellAmount>0)  // sell
		$volumeSellCAD:=($InventoryBalance*$prevRunningAvgSell)+$sellAmountCAD
		$buyInventory:=$buyInventory-$sellAmount
		
		If ($buyInventoryOld>0)
			$profitSell:=(calcMin($buyInventoryOld; $sellAmount)*($rate-$runningAvgBuy))  // this the profit of this single transaction
		Else 
			$profitSell:=0
		End if 
		$profitBuy:=0
		//$costOfGoodsSold:=$CostOFGoodsSold+($sellAmount*$runningAvgBuy)
	End if 
	
	If ($buyInventory<0)
		$sellInventory:=-$buyInventory
	Else 
		$sellInventory:=0
	End if 
	
	If ($buyInventory>0)
		If ($buyInventoryOld>=0)
			$runningAvgBuy:=(($buyInventoryOld*$runningAvgBuy)+$buyAmountCAD)/($buyInventoryOld+$buyAmount)
		Else 
			$runningAvgBuy:=$rate
		End if 
	Else 
		$runningAvgBuy:=0
	End if 
	
	If ($sellInventory>0)
		If ($sellInventoryOld>=0)
			$runningAvgsell:=(($sellInventoryOld*$runningAvgsell)+$sellAmountCAD)/($sellInventoryOld+$sellAmount)
		Else 
			$runningAvgsell:=$rate
		End if 
	Else 
		$runningAvgsell:=0
	End if 
	
	$sumProfitBuy:=$sumProfitBuy+$profitBuy
	$sumProfitSell:=$sumProfitSell+$profitSell
	
	NEXT RECORD:C51([Registers:10])
End for 

$profit:=$sumProfitBuy+$sumProfitSell
$costOfGoodsSold:=$sumSellAmountCAD-$profit

$inventoryBalance:=$buyInventory-$sellInventory
If ($buyInventory>0)
	$breakEvenAvg:=calcSafeDivide((($buyInventory*$runningAvgBuy)-$profit); $buyInventory)
	//$breakEvenAvg:=calcSafeDivide ((($inventoryBalance*$runningAvgBuy)-$profit);$InventoryBalance)
Else 
	$breakEvenAvg:=calcSafeDivide((($sellInventory*$runningAvgsell)+$profit); $sellInventory)
End if 

If ($currency=<>baseCurrency)
	$runningAvgBuy:=1
	$breakEvenAvg:=1
	$profit:=0
	$sumBuyAmountCAD:=0
	$sumSellAmountCAD:=0
	$runningAvgSell:=1
	$costOFGoodsSold:=0
End if 

$4->:=$runningAvgBuy
$5->:=$breakEvenAvg
$6->:=$profit

$7->:=$sumBuyAmountCAD
$8->:=$sumSellAmountCAD

$9->:=$runningAvgSell
$10->:=$costOFGoodsSold