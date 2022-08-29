//%attributes = {}

C_TEXT:C284($1; $currency)
C_DATE:C307($2; $toDate)
C_POINTER:C301($3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13; $14; $vSumBoughtPtr; $vSumSoldPtr; $vBalancePtr; $vSumFeesPtr; $vRunningAvgBuyPtr; $vRunningAvgSellPtr; $vBreakEvenPtr; $vCOGSPtr; $vInventoryCostPtr; $vInventoryShortPtr)
C_POINTER:C301($vVolumeBoughtCADPtr; $vVolumeSoldCADPtr)
$currency:=$1
$toDate:=$2

$vSumBoughtPtr:=$3
$vSumSoldPtr:=$4
$vBalancePtr:=$5
$vVolumeBoughtCADPtr:=$6
$vVolumeSoldCADPtr:=$7
$vSumFeesPtr:=$8
$vRunningAvgBuyPtr:=$9
$vRunningAvgSellPtr:=$10
$vBreakEvenPtr:=$11
$vCOGSPtr:=$12
$vInventoryCostPtr:=$13
$vInventoryShortPtr:=$14

C_REAL:C285($vSumDebit; $vSumCredit; $vBalance; $vSumBought; $vSumSold; $vSumFees)
C_REAL:C285($vRunningAvgBuy; $vRunningAvgSell; $vBreakEven; $vSalesProfit; $vVolumeBoughtCAD; $vVolumeSoldCAD; $vCOGS; $vInventoryCost; $vInventoryShort)

// Select the currency in the date range 
QUERY:C277([Registers:10]; [Registers:10]Currency:19=$currency; *)
QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=$toDate)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isTrade:38=True:C214)  // MUST be a trade (may also be a transfer)

$vSumDebit:=Sum:C1([Registers:10]Debit:8)
$vSumCredit:=Sum:C1([Registers:10]Credit:7)
$vBalance:=$vSumDebit-$vSumCredit

QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=False:C215)  // *****NEW ADDITION (EXCLUDE THE TRANSFERS)

$vSumBought:=Sum:C1([Registers:10]Debit:8)  // exclude the transfers in the sum
$vSumSold:=Sum:C1([Registers:10]Credit:7)  // exclude the transfers in the sum\ 
$vSumFees:=Sum:C1([Registers:10]totalFees:30)  // sum the fees
orderByRegisters

calcRunningVars(0; 0; 0; ->$vRunningAvgBuy; ->$vBreakEven; ->$vSalesProfit; ->$vVolumeBoughtCAD; ->$vVolumeSoldCAD; ->$vRunningAvgSell; ->$vCOGS)

$vInventoryCost:=$vBalance*$vRunningAvgBuy  // Cost of Inventory on hand
$vInventoryShort:=$vBalance*$vRunningAvgSell  // Position of short inventory in CAD

$vSumBoughtPtr->:=$vSumBought
$vSumSoldPtr->:=$vSumSold
$vBalancePtr->:=$vBalance
$vVolumeBoughtCADPtr->:=$vVolumeBoughtCAD
$vVolumeSoldCADPtr->:=$vVolumeSoldCAD
$vSumFeesPtr->:=$vSumFees
$vRunningAvgBuyPtr->:=$vRunningAvgBuy
$vRunningAvgSellPtr->:=$vRunningAvgSell
$vBreakEvenPtr->:=$vBreakEven
$vCOGSPtr->:=$vCOGS
$vInventoryCostPtr->:=$vInventoryCost
$vInventoryShortPtr->:=$vInventoryShort