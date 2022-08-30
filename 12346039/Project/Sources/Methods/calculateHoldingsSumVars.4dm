//%attributes = {}
// this method adds up the sum of inventory variables

calcCurrencyProfitVars(vFromDate; vToDate; True:C214)  // removed the comment TB: June 4th,08

accumulateReal(->vSumInventory; vInventoryInCAD)
accumulateReal(->vSumInventoryShort; vInventoryShortInCAD)
accumulateReal(->vSumVolumeSold; volumeSoldCAD)
accumulateReal(->vSumCOGS; vCostOfGoodsSoldCAD)
accumulateReal(->vSumNetProfits; vProfitAfterFeesInCAD)
accumulateReal(->vSumFeesReceived; vFeesReceivedInCAD)
accumulateReal(->vSumSalesProfits; vSalesProfitInCAD)