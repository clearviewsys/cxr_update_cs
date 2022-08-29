//%attributes = {}

// calcProfitVarsInCurrencyView

C_REAL:C285(vTotalBought; vTotalPaidInCAD; vAvgBuy)
C_REAL:C285(vTotalSol; vTotalReceivedInCAD; vAvgSell)
C_REAL:C285(vBreakEvenAvg; vCurrentMarketValue; vInventoryInCAD; vBalanceRemaining; vTotalProfitInCAD; vProfitPer1CurrencySold; vSalesProfitInCAD; vOpeningAssetInCAD)
C_REAL:C285(volumeBoughtCAD; volumeSoldCAD; vRunningAvgBuy; vMarketMinusInventory)
C_REAL:C285(vFeesReceivedInCAD)
C_REAL:C285(vProfitAfterFeesInCAD)

relateMany(->[Registers:10]; ->[Registers:10]Currency:19; ->[Currencies:6]CurrencyCode:1)
orderByRegisters

vTotalBought:=Sum:C1([Registers:10]Debit:8)
vTotalSold:=Sum:C1([Registers:10]Credit:7)
vFeesReceivedInCAD:=Sum:C1([Registers:10]feeLocal:29)

volumeBoughtCAD:=Sum:C1([Registers:10]DebitLocal:23)
volumeSoldCAD:=Sum:C1([Registers:10]CreditLocal:24)
vAvgBuy:=volumeBoughtCAD/vTotalBought
vAvgSell:=volumeSoldCAD/vTotalSold


// DO THE CALCULATIONS
vBalanceRemaining:=vTotalBought-vTotalSold  // remaining inventory of the currency
calcRunningVars(0; 0; 0; ->vRunningAvgBuy; ->vBreakEvenAvg; ->vSalesProfitInCAD)


vInventoryInCAD:=vBalanceRemaining*vRunningAvgBuy  // calculates today's inventory in CAD
vCurrentMarketValue:=vBalanceRemaining*[Currencies:6]SpotRateLocal:17  // inventory's worth in the current market

vMarketMinusInventory:=vCurrentMarketValue-vInventoryInCAD
vProfitAfterFeesInCAD:=vFeesReceivedInCAD+vSalesProfitInCAD

vProfitPer1CurrencySold:=calcSafeDivide(vSalesProfitInCAD; vTotalSold)  //proft per 1 unit of the currency
// the profit made on the sales only

