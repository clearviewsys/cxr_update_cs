C_LONGINT:C283($row)
C_POINTER:C301($columnPtr)
C_TEXT:C284($vCurrency; $vBranchID)
C_LONGINT:C283(cbShowInverseRates)

handleListboxColumnsSettings(Self:C308; ->[Reports:73]; "PL_Currencies"; "PL_summaryListBox")

If (Form event code:C388=On Double Clicked:K2:5)
	$ColumnPtr:=Focus object:C278
	// $Column contains a pointer to col2
	$Row:=$ColumnPtr->  //$Row equals 5
	If ($row>0)
		
		If (isSLAValid)
			$vCurrency:=arrCurrencies{$row}
			vCurrency:=$vCurrency
			//myConfirm ("Line by line P&L (proof of work) may take some time to prepare!";"Continue";"Cancel";"Line by Line P&L for "+$vCurrency)
			//If (OK=1)
			FORM GOTO PAGE:C247(2)
			DELAY PROCESS:C323(Current process:C322; 10)
			PL_fillCurrencyDetailListBox($vCurrency; VBRANCHID; vFromDate; vToDate; numToBoolean(cbShowInverseRates))
			//End if 
		Else 
			ALERT:C41("SLA Expired. The line by line version is only available under a valid SLA.")
		End if 
	End if 
End if 
