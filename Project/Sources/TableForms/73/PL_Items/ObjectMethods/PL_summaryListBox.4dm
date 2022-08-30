C_LONGINT:C283($row)
C_POINTER:C301($columnPtr)
C_TEXT:C284($itemID)

If (Form event code:C388=On Double Clicked:K2:5)
	$ColumnPtr:=Focus object:C278
	$row:=$ColumnPtr->
	If ($row>0)
		If (isSLAValid)
			$itemID:=arrItemIDs{$row}
			FORM GOTO PAGE:C247(2)
			OBJECT SET TITLE:C194(*; "title"; "Line by line P&L for "+$itemID)
			
			PLItems_fillDetailListBox($itemID; VBRANCHID; vFromDate; vToDate)
		Else 
			ALERT:C41("SLA Expired. The line by line version is only available under a valid SLA.")
		End if 
	End if 
End if 
