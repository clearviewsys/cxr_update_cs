//%attributes = {}
// PLItems_calcSummaryVars_server
// This method calculates the P&L variables on a selection of ItemsInOuts on the Server side (optimized for speed)


C_TEXT:C284($itemID; $1)
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

C_POINTER:C301($sumTax1Ptr; $19)
C_POINTER:C301($sumTax2Ptr; $20)

C_LONGINT:C283($i; $n)
C_REAL:C285($Buy; $Sell; $avgBuyRate; $ShortRate; $Inventory; $DebitLC; $CreditLC; $COGS; $profit; $net)  // line variables
C_REAL:C285($sumBuy; $sumSell; $sumCreditLC; $sumDebitLC; $sumFeesLC; $sumCOGS; $sumProfits; $sumNetProfit)  // sum variables

Case of 
		
	: (Count parameters:C259=20)
		$itemID:=$1
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
		
		$sumTax1Ptr:=$19
		$sumTax2Ptr:=$20
		
	Else 
		ASSERT:C1129(False:C215; "invalid number of params")
End case 

// The following three variables are meant to start with the previous value
$avgBuyRate:=$RunningAvgBuy  // avg buy rate continues based on the previous value
$ShortRate:=$RunningShortRate  // short rate sets to previous value
$Inventory:=$openingInventory  // inventory starts with the opening inventory

C_LONGINT:C283($numRecords)
$numRecords:=PL_queryItemsIOInDateRange($itemID; $branchID; $fromDate; $toDate)  // queries all relevant itemInOuts in date range

ARRAY REAL:C219($arrRates; $numRecords)
ARRAY REAL:C219($arrSells; $numRecords)
ARRAY REAL:C219($arrBuys; $numRecords)
ARRAY REAL:C219($arrSellsLC; $numRecords)
ARRAY REAL:C219($arrBuysLC; $numRecords)
ARRAY REAL:C219($arrFees; $numRecords)
//SELECTION TO ARRAY([ItemInOuts]OurRate;$arrRates)
FIRST RECORD:C50([ItemInOuts:40])
C_LONGINT:C283($index)
For ($index; 1; $numRecords)
	If ([ItemInOuts:40]Qty:8#0)
		//$arrRates{$index}:=([ItemInOuts]Amount)/([ItemInOuts]Qty)
		$arrRates{$index}:=[ItemInOuts:40]UnitPrice:9
	End if 
	If ([ItemInOuts:40]isSold:7=True:C214)
		$arrSells{$index}:=[ItemInOuts:40]Qty:8
		$arrSellsLC{$index}:=[ItemInOuts:40]Amount:22
		
		$sumTax1Ptr->:=$sumTax1Ptr->+[ItemInOuts:40]tax1:20
		$sumTax2Ptr->:=$sumTax2Ptr->+[ItemInOuts:40]tax2:21
		$arrBuys{$index}:=0
		$arrBuysLC{$index}:=0
	Else 
		$arrSells{$index}:=0
		$arrSellsLC{$index}:=0
		$arrBuys{$index}:=[ItemInOuts:40]Qty:8
		$arrBuysLC{$index}:=[ItemInOuts:40]Amount:22
		
		$sumTax1Ptr->:=$sumTax1Ptr->-[ItemInOuts:40]tax1:20
		$sumTax2Ptr->:=$sumTax2Ptr->-[ItemInOuts:40]tax2:21
	End if 
	$arrFees{$index}:=[ItemInOuts:40]FeeLocal:19
	NEXT RECORD:C51([ItemInOuts:40])
End for 

$sumBuy:=Sum:C1($arrBuys)
$sumSell:=Sum:C1($arrSells)
$sumFeesLC:=Sum:C1([ItemInOuts:40]FeeLocal:19)

$sumDebitLC:=Sum:C1($arrBuysLC)
$sumCreditLC:=Sum:C1($arrSellsLC)
PL_calcSummaryVars_onArrays($Inventory; $runningAvgBuy; $runningShortRate; ->$arrBuys; ->$arrSells; ->$arrRates; ->$arrBuysLC; ->$arrSellsLC; ->$arrFees; ->$avgbuyRate; ->$shortRate; ->$inventory; ->$sumCOGS; ->$sumProfits)

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
CLEAR VARIABLE:C89($arrBuysLC)
CLEAR VARIABLE:C89($arrSellsLC)
