C_LONGINT:C283(cbAutoRefresh)

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		fillCurrencyRateSheetArrays(False:C215)
		If (LISTBOX Get number of rows:C915(cur_RateTable)>0)
			EDIT ITEM:C870(cur_RateTable; 1)
		End if 
		
End case 