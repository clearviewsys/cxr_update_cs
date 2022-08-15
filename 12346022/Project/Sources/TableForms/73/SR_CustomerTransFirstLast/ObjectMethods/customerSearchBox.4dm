C_LONGINT:C283($formEvent)
C_POINTER:C301($listBoxPtr)
$listBoxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "customerFirstLastTransLB")
$formEvent:=Form event code:C388


Case of 
	: ($formEvent=On Losing Focus:K2:8)
		//validating the search term
		If (customerSearchTermPtr->#"")
			//$customerSearchTerm:="@"+customerSearchTermPtr->+"@"
			pickCustomer(customerSearchTermPtr)
			
			listbox_deleteAllRows($listBoxPtr)
			Check_CustomersFirstLastTrans(listBoxPointer; ->arrCustomerId; ->arrCustName; ->arrFirstTransDate; ->arrLastTransDate; ->arrTotalTrans; ->arrTransVolume)
		End if 
End case 