C_LONGINT:C283(cbHideColumn2)

If (cbHideColumn2=1)
	LISTBOX SET COLUMN WIDTH:C833(*; "num_Qty 2"; 0)
	LISTBOX SET COLUMN WIDTH:C833(*; "num_Total Qtys"; 0)
	OBJECT SET ENTERABLE:C238(*; "arrQty2"; False:C215)
	listbox_editCurrentRow("arrQty1"; ->lbTellerProof)
	
Else 
	LISTBOX SET COLUMN WIDTH:C833(*; "num_Qty 2"; 120)
	LISTBOX SET COLUMN WIDTH:C833(*; "num_Total Qtys"; 120)
	OBJECT SET ENTERABLE:C238(*; "arrQty2"; True:C214)
	listbox_editCurrentRow("arrQty1"; ->lbTellerProof)
	
End if 
