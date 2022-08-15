//%attributes = {}
// handleTellerProofCB
// this method handle the combo box in the tellerproof form

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		C_TEXT:C284(vCurrency)
		
		initOrderVars
		
		
		//_O_ARRAY STRING(3;cbCurrencies;0)
		ARRAY TEXT:C222(cbCurrencies; 0)
		selectTradableCurrencies
		orderByCurrencies
		SELECTION TO ARRAY:C260([Currencies:6]ISO4217:31; cbCurrencies)
		
		If (Size of array:C274(cbCurrencies)>0)  // if the list of currencies has at least one currency
			//SORT ARRAY(cbCurrencies)
			cbCurrencies:=1
			vCurrency:=cbCurrencies{1}
			cbCurrencies{0}:=vCurrency
			
			//fillOrderFormArrays (vCurrency)
		Else 
			myAlert("There were no tradeable currencies available.")
		End if 
		
		
	: ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))  // on clicked or on data change 
		
		C_TEXT:C284(vCurrency)
		C_LONGINT:C283($position)
		
		vCurrency:=cbCurrencies{cbCurrencies}  // first assign vCurrency to the selection from the pulldown
		pickCurrency(->vCurrency)  // pick the correct currency using the picker
		cbCurrencies{cbCurrencies}:=vCurrency  // then reassign the pulldown menu to the picked currency
		
		fillOrderFormArrays(vCurrency)
		// highlight and edit the position of the currency if it's already in the list
		
		$position:=Find in array:C230(arrCurr; vCurrency)
		
		If ($position>0)
			lbaOrderLines{$position}:=True:C214
			LISTBOX SELECT ROW:C912(*; "OrderLines"; $position)
			listbox_editCurrentRow("arrQty"; ->lbaOrderLines)
			//listbox_editFocusedRow ("arrQty";->lbaOrderLines)
		End if 
		
End case 

