C_LONGINT:C283($formEvent)
C_POINTER:C301($listBoxPointer)
$listBoxPointer:=OBJECT Get pointer:C1124(Object named:K67:5; "customerStatsListBox2")
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Losing Focus:K2:8)
		//validating the search term
		If (customerSearchTermPtr->#"")
			pickCustomer(customerSearchTermPtr)
			RELATE MANY SELECTION:C340([Registers:10]CustomerID:5)
			listbox_deleteAllRows($listBoxPointer)
			calcCustmrTransYearlyStats($listBoxPointer; ->arrCustomerId; ->arrYears; ->arrTransactionVolume; ->arrAvgBuys; ->arrBuyQtys)
		End if 
End case 