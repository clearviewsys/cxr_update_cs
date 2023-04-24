C_REAL:C285(vInventoryInCAD; vInventoryShortInCAD; vLiquidationValue; vLiquidationGain; vLiquidationRate)


vLiquidationValue:=vBalanceRemaining*vLiquidationRate
vLiquidationGain:=vLiquidationValue-(vInventoryInCAD+vInventoryShortInCAD)