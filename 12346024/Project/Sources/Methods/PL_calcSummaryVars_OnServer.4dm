//%attributes = {"executedOnServer":true}
// PL_calcSummaryVars_onServer
// This method calculates the P&L variables on a selection of registers on the Server side (optimized for speed)


C_TEXT:C284($curr; $1)
C_TEXT:C284($branchID; $2)
C_DATE:C307($fromDate; $3)
C_DATE:C307($toDate; $4)

C_REAL:C285($openingInventory; $5)  // the opening inventory 
C_REAL:C285($RunningAvgBuy; $6)  // the avg rate (if inventory is positive) (BEFORE)
C_REAL:C285($RunningShortRate; $7)  // the avg rate (if opening inventory is negative) (BEFORE)

C_POINTER:C301($avgBuyRatePtr; $8)  // new value for AvgBuy will be returned in this
C_POINTER:C301($shortRatePtr; $9)  // new Value for AvgShort will be returned in this
C_POINTER:C301($InventoryPtr; $10)  // this value of Inventory will be returned here

C_POINTER:C301($sumBuyPtr; $11)
C_POINTER:C301($sumSellPtr; $12)
C_POINTER:C301($sumDebitLCPtr; $13)
C_POINTER:C301($sumCreditLCPtr; $14)
C_POINTER:C301($sumFeesPtr; $15)

C_POINTER:C301($sumProfitsPtr; $16)
C_POINTER:C301($sumCOGSPtr; $17)
C_POINTER:C301($sumNetProfitPtr; $18)

C_LONGINT:C283($i; $n; $m)
C_REAL:C285($Buy; $Sell; $avgBuyRate; $ShortRate; $Inventory; $DebitLC; $CreditLC; $COGS; $profit; $net)  // line variables
C_REAL:C285($sumBuy; $sumSell; $sumCreditLC; $sumDebitLC; $sumFeesLC; $sumCOGS; $sumProfits; $sumNetProfit)  // sum variables

Case of 
		
	: (Count parameters:C259=18)
		$curr:=$1
		$branchID:=$2
		$fromDate:=$3
		$toDate:=$4
		
		$openingInventory:=$5
		$RunningAvgBuy:=$6
		$RunningShortRate:=$7
		
		$avgBuyRatePtr:=$8
		$shortRatePtr:=$9
		$InventoryPtr:=$10
		$sumBuyPtr:=$11
		$sumSellPtr:=$12
		$sumDebitLCPtr:=$13
		$sumCreditLCPtr:=$14
		$sumFeesPtr:=$15
		$sumProfitsPtr:=$16
		$sumCOGSPtr:=$17
		$sumNetProfitPtr:=$18
		
	Else 
		ASSERT:C1129(False:C215; "invalid number of params")
End case 

// The following three variables are meant to start with the previous value
$avgBuyRate:=$RunningAvgBuy  // avg buy rate continues based on the previous value
$ShortRate:=$RunningShortRate  // short rate sets to previous value
$Inventory:=$openingInventory  // inventory starts with the opening inventory

$m:=PL_queryRegistersInDateRange($curr; $branchID; $fromDate; $toDate)  // queries all relevant registers in date range
SELECTION TO ARRAY:C260([Registers:10]Debit:8; $arrBuys; [Registers:10]Credit:7; $arrSells; [Registers:10]OurRate:25; $arrRates; [Registers:10]DebitLocal:23; $arrBuysLC; [Registers:10]CreditLocal:24; $arrSellsLC; [Registers:10]totalFees:30; $arrFees)

$sumBuy:=Sum:C1($arrBuys)
$sumSell:=Sum:C1($arrSells)
$sumFeesLC:=Sum:C1($arrFees)

If ($curr=<>BASECURRENCY)  // for optimization sake it is easier to calculate the base currency differently
	$sumDebitLC:=$sumBuy
	$sumCreditLC:=$sumSell
	$avgBuyRate:=1
	$sumProfits:=0
	$sumCOGS:=0
	$sumNetProfit:=$sumFeesLC  // net profit is based on the sum of fees
Else 
	$sumDebitLC:=Sum:C1([Registers:10]DebitLocal:23)
	$sumCreditLC:=Sum:C1([Registers:10]CreditLocal:24)
	PL_calcSummaryVars_onArrays($Inventory; $runningAvgBuy; $runningShortRate; ->$arrBuys; ->$arrSells; ->$arrRates; ->$arrBuysLC; ->$arrSellsLC; ->$arrFees; ->$avgbuyRate; ->$shortRate; ->$inventory; ->$sumCOGS; ->$sumProfits)
End if 

$sumBuyPtr->:=$sumBuy
$sumSellPtr->:=$sumSell

$sumDebitLCPtr->:=$sumDebitLC
$sumCreditLCPtr->:=$sumCreditLC

$sumFeesPtr->:=$sumFeesLC
$sumCOGSPtr->:=$sumCOGS
$sumProfitsPtr->:=$sumProfits
$sumNetProfit:=$sumProfits+$sumFeesLC

$avgBuyRatePtr->:=$avgBuyRate
$shortRatePtr->:=$ShortRate
$inventoryPtr->:=$inventory
$sumNetProfitPtr->:=$sumNetProfit
// cleanup after arrays are used - not necessary in case of local arrays but just for good practice
CLEAR VARIABLE:C89($arrBuys)
CLEAR VARIABLE:C89($arrSells)
CLEAR VARIABLE:C89($arrRates)