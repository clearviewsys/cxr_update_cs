//%attributes = {}
// PL_calcRowByRowVars ( buy; sell ; rate; buyLC; sellLC; feesLC;  ->inventory; ->avgBuy ; ->shortRate; ->profitRow)
// PRE: inventory should be running ; historical avgBuy and short Rate should be provided from the last row;
// POST: both averages will be recalculated and returned; profit for the row will be returned

C_REAL:C285($buy; $sell; $buyLC; $sellLC; $feesLC; $sumDebitLC_PRE; $sumCreditLC_PRE; $inventoryPRE; $inventoryPOST; $rate; $avgBuyRatePRE; $avgBuyRatePOST; $avgSellRatePRE; $avgSellRatePOST; $profitRow)
// calcPCRow ($buy; $sell; $rate; ->inventory; ->avgBuyRate;->shortRate;->profit)
// this method will return the new inventory, new averages, and new profit


C_BOOLEAN:C305($isLongBuy; $isLongSell; $isLongShort; $isShortBuy; $isShortSell; $isShortLong; $isFirstBuy; $isFirstSell)

C_REAL:C285($1; $2; $3; $4; $5; $6)
C_POINTER:C301($7; $8; $9; $10)

Case of 
	: (Count parameters:C259=10)
		$buy:=$1  // buy 
		$sell:=$2  // sell
		$rate:=$3  // rate
		$buyLC:=$4  // debitLC
		$sellLC:=$5  // creditLC
		$feesLC:=$6  // fees Local (NEW)
		
		$inventoryPRE:=$7->  // inventory of the previous line 
		$avgBuyRatePRE:=$8->  // avg Buy rate of the previous line
		$avgSellRatePRE:=$9->  // avg sell rate (short rate) for the previous line
		$profitRow:=$10->  // profit calculated for this row
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$inventoryPOST:=$inventoryPRE+$buy-$sell

$isLongBuy:=($inventoryPRE>=0) & ($buy>0)  // inventory is positive or zero and we buy more
$isLongSell:=($inventoryPRE>=0) & ($sell>0) & ($inventoryPOST>=0)  // inventory is positive or zero and we sell and remain positive
$isLongShort:=($inventoryPRE>=0) & ($inventoryPOST<0)  // inventory is positive or zero and we sell more than we have

$isShortBuy:=($inventoryPRE<0) & ($buy>0) & ($inventoryPOST<0)  // inventory is negative and we buy, yet remain in negative
$isShortSell:=($inventoryPRE<0) & ($sell>0)  // inventory is negative and we sell (more negative)
$isShortLong:=($inventoryPRE<0) & ($inventoryPOST>=0)  // inventory is negative and it becomes positive or zero after buying

Case of 
	: ($isLongBuy)  // we are positive and then we buy more - LONG BUY
		//$avgBuyRatePOST:=(($rate*$buy)+($avgBuyRatePRE*$inventoryPRE))/$inventoryPOST
		$sumDebitLC_PRE:=$avgBuyRatePRE*$inventoryPRE  // replace this with a running value coming from before
		//$avgBuyRatePOST:=($buyLC+$sumDebitLC_PRE)/$inventoryPOST
		$avgBuyRatePOST:=($buyLC+$feesLC+$sumDebitLC_PRE)/$inventoryPOST  // added the fees here
		
		$avgSellRatePOST:=0
		$profitRow:=0
		
	: ($isLongSell)  // we are positive and then we sell - LONG SELL
		$avgBuyRatePOST:=$avgBuyRatePRE
		$avgSellRatePOST:=0
		$profitRow:=$sell*($rate-$avgBuyRatePRE)
		
	: ($isLongShort)  // DIVE - LONG SHORT
		$avgBuyRatePOST:=0
		$avgSellRatePOST:=$rate
		$profitRow:=$inventoryPRE*($rate-$avgBuyRatePRE)  // all the current inventory should be sold and then some so profit is maxed
		
	: ($isShortBuy)  // we are negative and then we buy a little, we make a bit of profit - SHORT BUY
		$avgBuyRatePOST:=0
		$avgSellRatePOST:=$avgSellRatePRE
		$profitRow:=$buy*($avgSellRatePRE-$rate)
		
	: ($isShortSell)  // we are negative, we sell more - SHORT SELL
		$avgBuyRatePOST:=0
		//$avgSellRatePOST:=(($sell*$rate)+($avgSellRatePRE*Abs($inventoryPRE)))/Abs($inventoryPOST)
		$sumCreditLC_PRE:=$avgSellRatePRE*Abs:C99($inventoryPRE)  // replace this with a running value instead of calculating for each line
		$avgSellRatePOST:=($sellLC+$sumCreditLC_PRE-$feesLC)/Abs:C99($inventoryPOST)  // deduct the fee (because it's already in the sellLC)
		$profitRow:=0
		
	: ($isShortLong)  // RISE - SHORT LONG
		$avgBuyRatePOST:=$rate
		$avgSellRatePOST:=0
		$profitRow:=Abs:C99($inventoryPRE)*($avgSellRatePRE-$rate)  // all the current inventory should be sold and then some so profit is maxed
		
	Else 
		//ASSERT(False;"We missed a case; we technically shouldn't reach this state")
		
End case 


$7->:=$inventoryPOST
$8->:=$avgBuyRatePOST
$9->:=$avgSellRatePOST
$10->:=$profitRow
