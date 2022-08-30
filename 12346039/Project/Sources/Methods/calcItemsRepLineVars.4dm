//%attributes = {}
C_REAL:C285(vOpeningInventory; vSumQtyIn; vSumQtyOut; vInventory; $vSumVolumeIn; $vSumVolumeOut)
getItemInOutSums([Items:39]ItemID:1; ->vOpeningInventory; ->vSumQtyIn; ->vSumQtyOut; ->vInventory; ->$vSumVolumeIn; ->$vSumVolumeOut; vFromDate; vToDate; numToBoolean(cbApplyDateRange))
