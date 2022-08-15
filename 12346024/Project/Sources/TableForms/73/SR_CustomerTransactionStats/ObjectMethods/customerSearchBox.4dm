C_LONGINT:C283($formEvent)
C_POINTER:C301($listBoxPtr)
$listBoxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "customerStatsListBox")
$formEvent:=Form event code:C388


Case of 
	: ($formEvent=On Losing Focus:K2:8)
		//validating the search term
		If (customerSearchTermPtr->#"")
			//$customerSearchTerm:="@"+customerSearchTermPtr->+"@"
			pickCustomer(customerSearchTermPtr)
			
			listbox_deleteAllRows($listBoxPtr)
			calcCustmrTransactStats($listBoxPtr; ->arrCustomerIdAndNames; ->arrTransTypes; ->arrDescriptions; ->arrTotalBuys; ->arrTotalSells; ->arrAvgBuys; ->arrAvgSells; ->arrBuyQtys; ->arrSellQtys)
		End if 
End case 