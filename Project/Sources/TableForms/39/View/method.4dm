handleViewForm
//RELATE MANY([Items]ItemID)
C_REAL:C285(vSumOpeningQtyIn; vSumOpeningQtyOut; vSumOpeningInventory; vSumOpeningVolumeIn; vSumOpeningVolumeOut)
C_REAL:C285(vSumQtyIn; vSumQtyOut; vSumInventory; vSumVolumeIn; vSumVolumeOut)
C_REAL:C285(vSumTotalQtyIn; vSumTotalQtyOut; vSumTotalInventory; vSumTotalVolumeIn; vSumTotalVolumeOut)


C_DATE:C307($vFromDate; $vToDate)

If (cbApplyDateRange=1)
	$vFromDate:=vFromDate
	$vToDate:=vToDate
Else 
	$vFromDate:=Date:C102("00/00/00")
	$vToDate:=Current date:C33
End if 


If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11) | (Form event code:C388=On Clicked:K2:4))
	// 1ST : load all the registers for this account 
	RELATE MANY:C262([Items:39]ItemID:1)
	
	//relateMany (->[ItemInOuts];->[ItemInOuts]ItemID;->[Items]ItemID)  // load all the history for this Item
	C_REAL:C285($opening)
	// 2ND : constrain the ending period
	QUERY SELECTION:C341([ItemInOuts:40];  & ; [ItemInOuts:40]Date:3<=$vToDate)
	
	// 3RD: calculate the sum from beginning to toDate
	getItemInOutSums([Items:39]ItemID:1; ->$opening; ->vSumTotalQtyIn; ->vSumTotalQtyOut; ->vSumTotalInventory; ->vSumTotalVolumeIn; ->vSumTotalVolumeOut; !00-00-00!; $vToDate; True:C214)
	// 4TH: constrain the starting period
	QUERY SELECTION:C341([ItemInOuts:40]; [ItemInOuts:40]Date:3>=$vFromDate)
	
	// 5TH: calculate the other sums
	getItemInOutSums([Items:39]ItemID:1; ->$opening; ->vSumQtyIn; ->vSumQtyOut; ->vSumInventory; ->vSumVolumeIn; ->vSumVolumeOut; $vFromDate; $vToDate; True:C214)
	
	vSumOpeningQtyIn:=vSumTotalQtyIn-vSumQtyIn
	vSumOpeningQtyOut:=vSumTotalQtyOut-vSumQtyOut
	vSumOpeningInventory:=vSumOpeningQtyIn-vSumOpeningQtyOut
	
	vSumOpeningVolumeIn:=vSumTotalVolumeIn-vSumVolumeIn
	vSumOpeningVolumeOut:=vSumTotalVolumeOut-vSumVolumeOut
	//vSumOpeningInventory:=vSumOpeningVolumeIn-vSumOpeningVolumeOut
	
	orderByItemInOuts
End if 
