C_LONGINT:C283($formEvent)
C_POINTER:C301($listBoxPtr)
$listBoxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "customerTop100")
$formEvent:=Form event code:C388


Case of 
	: ($formEvent=On Losing Focus:K2:8)
		//validating the search term
		If (customerSearchTermPtr->#"")
			//$customerSearchTerm:="@"+customerSearchTermPtr->+"@"
			pickCustomer(customerSearchTermPtr)
			QUERY:C277([Registers:10]; [Registers:10]CustomerID:5=[Customers:3]CustomerID:1)
			listbox_deleteAllRows($listBoxPtr)
			Check_CustomersTop100(listBoxPointer; ->arrCustomerFullName; ->arrDatePeriod; ->arrTransactionType; ->arrTotalTrans; ->arrTransCount; ->arrNationality; ->arrIDNumber)
		End if 
End case 