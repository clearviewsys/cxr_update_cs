//%attributes = {}
// PL_calcSummaryVars_OnArrays ( param1; ... ; ->param8)
// Written by Tiran Behrouz on Feb 2018

// 1: OpeningInventory; 
// 2: RunningAvgBuy; 
// 3: RunningShortRate; 

// 4: -> arrBuys;
// 5: -> arrSells;
// 6: -> arrRates;

// 7: -> arrBuyLC;  (new params)
// 8: -> arrSellLC; (new params)

// 9: -> avgBuyRate;
// 10: -> shortRate;
// 11: -> inventory;

// 12: -> sumCOGS; 
// 13: -> sumProfits; 

// A generic method needs to be made to work on array or selection of records
// PRE: Arrays of Buy/Sell/Rates must be prepared and sent to this

// POST: 
// THIS METHOD IS NON-FUNCTIONAl AT THIS POINT

C_REAL:C285($openingInventory; $1)  // the opening inventory 
C_REAL:C285($RunningAvgBuy; $2)  // the avg rate (if inventory is positive) (BEFORE)
C_REAL:C285($RunningShortRate; $3)  // the avg rate (if opening inventory is negative) (BEFORE)

C_POINTER:C301($arrBuyPtr; $4)  // pointer to the array containing Buys
C_POINTER:C301($arrSellPtr; $5)  // pointer to the array containing Sells
C_POINTER:C301($arrRatePtr; $6)  // pointer to the array containing Rates (direct Rates)
C_POINTER:C301($arrBuyLCPtr; $7)  // pointer to the array containing Buys
C_POINTER:C301($arrSellLCPtr; $8)  // pointer to the array containing Sells
C_POINTER:C301($arrFeesPtr; $9)  // pointer to the array containing Fees (local)

C_POINTER:C301($avgBuyRatePtr; $10)  // new value for AvgBuy will be returned in this
C_POINTER:C301($shortRatePtr; $11)  // new Value for AvgShort will be returned in this
C_POINTER:C301($InventoryPtr; $12)  // the value of  new Inventory will be returned here

C_POINTER:C301($sumCOGSPtr; $13)
C_POINTER:C301($sumProfitsPtr; $14)

C_LONGINT:C283($i; $n)
C_REAL:C285($Buy; $Sell; $buyLC; $sellLC; $feesLC; $avgBuyRate; $ShortRate; $Inventory; $DebitLC; $CreditLC; $COGS; $profit; $net)  // line variables
C_REAL:C285($sumBuy; $sumSell; $sumCreditLC; $sumDebitLC; $sumFeesLC; $sumCOGS; $sumProfit; $sumNetProfit; $rate)  // sum variables

Case of 
		
	: (Count parameters:C259=14)
		$openingInventory:=$1
		$RunningAvgBuy:=$2
		$RunningShortRate:=$3
		
		$arrBuyPtr:=$4
		$arrSellPtr:=$5
		$arrRatePtr:=$6
		
		$arrBuyLCPtr:=$7  // new params
		$arrSellLCPTr:=$8  // new params
		$arrFeesPtr:=$9  // new params (very new) TB: after the bug found by Giannis
		
		$avgBuyRatePtr:=$10
		$shortRatePtr:=$11
		$InventoryPtr:=$12
		
		$sumCOGSPtr:=$13
		$sumProfitsPtr:=$14
	Else 
		//ASSERT(False;"Invalid number of params")
		assertInvalidNumberOfParams
End case 

// The following three variables are meant to start with the previous value
$avgBuyRate:=$RunningAvgBuy  // avg buy rate continues based on the previous value
$ShortRate:=$RunningShortRate  // short rate sets to previous value
$Inventory:=$openingInventory  // inventory starts with the opening inventory

$n:=Size of array:C274($arrRatePtr->)  // number of elements in the array rates
For ($i; 1; $n)
	
	$Buy:=$arrBuyPtr->{$i}
	$sell:=$arrSellPtr->{$i}
	$rate:=$arrRatePtr->{$i}
	$BuyLC:=$arrBuyLCPtr->{$i}
	$sellLC:=$arrSellLCPTr->{$i}
	$feesLC:=$arrFeesPtr->{$i}  // the fees
	
	PL_calcRowByRowVars($buy; $sell; $rate; $buyLC; $sellLC; $feesLC; ->$inventory; ->$avgBuyRate; ->$shortRate; ->$profit)
	$sumProfit:=$sumProfit+$profit
	//If ($sell>0)
	//$cogs:=($sell*$avgBuyRate)  // redefined
	$cogs:=$buyLC-$profit  // modified the formula to match the definition of the book (Revenue - profit)
	$sumCOGS:=$sumCOGS+$COGS
	//Else 
	//$cogs:=0
	//End if 
	
End for 

$InventoryPtr->:=$inventory  // running inventory
$avgBuyRatePtr->:=$avgBuyRate  // average buy rate (cost of 1 unit)
$shortRatePtr->:=$shortRate  // short rate
$sumCOGSPtr->:=$sumCOGS  // Cost of Goods Sold
$sumProfitsPtr->:=$sumProfit