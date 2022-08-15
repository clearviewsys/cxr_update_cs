C_LONGINT:C283($row)
C_POINTER:C301($columnPtr)
C_TEXT:C284($vCurrency; $vBranchID)

If (Form event code:C388=On Clicked:K2:4)
	$ColumnPtr:=Focus object:C278
	// $Column contains a pointer to col2
	$Row:=$ColumnPtr->  //$Row equals 5
	If ($row>0)
		
		If (isSLAValid)
			$vCurrency:=arrCurrencies{$row}
			FORM GOTO PAGE:C247(2)
			PL_fillCurrencyDetailListBox($vCurrency; VBRANCHID; vFromDate; vToDate)
		Else 
			ALERT:C41("Your SLA has expired. This feature is only available with a valid SLA")
		End if 
	End if 
End if 
