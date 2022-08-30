//%attributes = {}
// calcPLRow ( buy; sell ; rate; ->inventory; ->avgBuy ; ->shortRate; ->profitRow)
// PRE: inventory should be running ; historical avgBuy and short Rate should be provided
// POST: avgerages will be recalculated; profit for the row will be returned

C_REAL:C285($buy; $sell; $inventoryPRE; $inventoryPOST; $rate; $avgBuyRatePRE; $avgBuyRatePOST; $avgSellRatePRE; $avgSellRatePOST; $profitRow)
// calcPCRow ($buy; $sell; $rate; ->inventory; ->avgBuyRate;->shortRate;->profit)
// this method will return the new inventory, new averages, and new profit


C_BOOLEAN:C305($isLongBuy; $isLongSell; $isLongShort; $isShortBuy; $isShortSell; $isShortLong; $isFirstBuy; $isFirstSell)

C_REAL:C285($1; $2; $3)
C_POINTER:C301($4; $5; $6; $7)

$buy:=$1
$sell:=$2
$rate:=$3

$inventoryPRE:=$4->
$avgBuyRatePRE:=$5->
$avgSellRatePRE:=$6->
$profitRow:=$7->


$inventoryPOST:=$inventoryPRE+$buy-$sell

$isLongBuy:=($inventoryPRE>=0) & ($buy>0)  // inventory is positive or zero and we buy more
$isLongSell:=($inventoryPRE>=0) & ($sell>0) & ($inventoryPOST>=0)  // inventory is positive or zero and we sell and remain positive
$isLongShort:=($inventoryPRE>=0) & ($inventoryPOST<0)  // inventory is positive or zero and we sell more than we have
$isShortBuy:=($inventoryPRE<0) & ($buy>0) & ($inventoryPOST<0)  // inventory is negative and we buy, yet remain in negative
$isShortSell:=($inventoryPRE<0) & ($sell>0)  // inventory is negative and we sell (more negative)
$isShortLong:=($inventoryPRE<0) & ($inventoryPOST>=0)  // inventory is negative and it becomes positive or zero after buying

Case of 
	: ($isLongBuy)  // we are positive and then we buy more
		$avgBuyRatePOST:=(($rate*$buy)+($avgBuyRatePRE*$inventoryPRE))/$inventoryPOST
		$avgSellRatePOST:=0
		$profitRow:=0
		
	: ($isLongSell)  // we are positive and then we sell
		$avgBuyRatePOST:=$avgBuyRatePRE
		$avgSellRatePOST:=0
		$profitRow:=$sell*($rate-$avgBuyRatePRE)
		
	: ($isLongShort)  // DIVE 
		$avgBuyRatePOST:=0
		$avgSellRatePOST:=$rate
		$profitRow:=$inventoryPRE*($rate-$avgBuyRatePRE)  // all the current inventory should be sold and then some so profit is maxed
		
	: ($isShortBuy)  // we are negative and then we buy a little, we make a bit of profit 
		$avgBuyRatePOST:=0
		$avgSellRatePOST:=$avgSellRatePRE
		$profitRow:=$buy*($avgSellRatePRE-$rate)
		
	: ($isShortSell)  // we are negative, we sell more
		$avgBuyRatePOST:=0
		$avgSellRatePOST:=(($sell*$rate)+($avgSellRatePRE*Abs:C99($inventoryPRE)))/Abs:C99($inventoryPOST)
		$profitRow:=0
		
	: ($isShortLong)  // RISE
		$avgBuyRatePOST:=$rate
		$avgSellRatePOST:=0
		$profitRow:=Abs:C99($inventoryPRE)*($avgSellRatePRE-$rate)  // all the current inventory should be sold and then some so profit is maxed
		
	Else 
		//ASSERT(False;"We missed a case; we technically shouldn't reach this state")
End case 


$4->:=$inventoryPOST
$5->:=$avgBuyRatePOST
$6->:=$avgSellRatePOST
$7->:=$profitRow
