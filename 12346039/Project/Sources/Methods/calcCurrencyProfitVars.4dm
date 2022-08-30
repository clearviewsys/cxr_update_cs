//%attributes = {}
// calcCurrencyProfitVars (fromDate;toDate;applyDate:boolean)
C_DATE:C307($fromDate; $toDate)
C_BOOLEAN:C305($applyDateRange)
C_TEXT:C284($tBranch)
$fromDate:=$1
$toDate:=$2
$applyDateRange:=$3

C_REAL:C285(vTotalBought; vTotalPaidInCAD; vAvgBuy)
C_REAL:C285(vTotalSol; vTotalReceivedInCAD; vAvgSell)
C_REAL:C285(vBreakEvenAvg; vCurrentMarketValue; vInventoryInCAD; vBalanceRemaining; vTotalProfitInCAD; vProfitPer1CurrencySold; vSalesProfitInCAD; vOpeningAssetInCAD)
C_REAL:C285(volumeBoughtCAD; volumeSoldCAD; vRunningAvgBuy; vRunningAvgSell; vMarketMinusInventory)
C_REAL:C285(vFeesReceivedInCAD)
C_REAL:C285(vProfitAfterFeesInCAD)
C_REAL:C285(vInventoryShortInCAD)
C_REAL:C285(vCostOFGoodsSoldCAD)
C_REAL:C285(vLiquidationRate; vLiquidationValue; vLiquidationGain)
C_REAL:C285(vProfitOverPeriod)
C_REAL:C285(vTransferIn; vTransferOut; vInventoryIn; vInventoryOut)

relateMany(->[Registers:10]; ->[Registers:10]Currency:19; ->[Currencies:6]CurrencyCode:1)
filterRegistersInDateRange($fromDate; $toDate; $applyDateRange)
//QUERY SELECTION([Registers];[Registers]isTrade=True)`   commented by TB , Aug 28, 2009 since the transfer amount were not correct

vInventoryIn:=Sum:C1([Registers:10]Debit:8)
vInventoryOut:=Sum:C1([Registers:10]Credit:7)
vBalanceRemaining:=vInventoryIn-vInventoryOut

QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=False:C215; *)  // *****NEW ADDITION (EXCLUDE THE TRANSFERS)

//XOM --- filter to just the current site 11/2/16
C_BOOLEAN:C305(vbAltKey)
If (vbAltKey)
	$tBranch:=getBranchID
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterID:1=($tBranch+"@"))
End if 


vTotalBought:=Sum:C1([Registers:10]Debit:8)  // exclude the transfers in the sum
vTotalSold:=Sum:C1([Registers:10]Credit:7)  // exclude the transfers in the sum

vTransferIn:=vInventoryIn-vTotalBought
vTransferOut:=vInventoryOut-vTotalSold

vFeesReceivedInCAD:=Sum:C1([Registers:10]totalFees:30)

orderByRegisters



// DO THE CALCULATIONS
calcRunningVars(0; 0; 0; ->vRunningAvgBuy; ->vBreakEvenAvg; ->vSalesProfitInCAD; ->volumeBoughtCAD; ->volumeSoldCAD; ->vRunningAvgSell; ->vCostOfGoodsSoldCAD)
vAvgBuy:=calcSafeDivide(volumeBoughtCAD; vTotalBought)
vAvgSell:=calcSafeDivide(volumeSoldCAD; vTotalSold)

vProfitOverPeriod:=(vAvgSell-vAvgBuy)*calcMin(vTotalSold; vTotalBought)

vInventoryInCAD:=vBalanceRemaining*vRunningAvgBuy  // calculates today's inventory in CAD
vInventoryShortInCAD:=vBalanceRemaining*vRunningAvgSell  //

vCurrentMarketValue:=vBalanceRemaining*[Currencies:6]SpotRateLocal:17  // inventory's worth in the current market

vMarketMinusInventory:=vCurrentMarketValue-vInventoryInCAD
vProfitAfterFeesInCAD:=vFeesReceivedInCAD+vSalesProfitInCAD

vProfitPer1CurrencySold:=calcSafeDivide(vSalesProfitInCAD; vTotalSold)  //proft per 1 unit of the currency
// the profit made on the sales only

vLiquidationRate:=0
vLiquidationValue:=0
vLiquidationGain:=0

C_REAL:C285(vRunningAvgBuyInv; vRunningAvgSellInv; vBreakEvenAvgInv)
vRunningAvgBuyInv:=calcSafeDivide(1; vRunningAvgBuy)
vRunningAvgSellInv:=calcSafeDivide(1; vRunningAvgSell)
vBreakEvenAvgInv:=calcSafeDivide(1; vBreakEvenAvg)

