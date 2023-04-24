//author: Jonna
//date: 21st January 2021
//form method for customer Last and First transaction report 
C_LONGINT:C283($formEvent)
C_DATE:C307(vFromDate; vToDate)
C_TEXT:C284(vBranchID)
C_POINTER:C301(customerSearchTermPtr)  //for customer search box
C_POINTER:C301(listBoxPointer)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Load:K2:1)
		OBJECT SET TITLE:C194(*; "ReportTitle"; "Top 100 Customers")
		customerSearchTermPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "customerSearchBox")
		listBoxPointer:=OBJECT Get pointer:C1124(Object named:K67:5; "customerTop100")
		ARRAY TEXT:C222(arrCustomerFullName; 0)
		ARRAY TEXT:C222(arrDatePeriod; 0)
		ARRAY TEXT:C222(arrTransactionType; 0)
		ARRAY REAL:C219(arrTotalTrans; 0)
		ARRAY LONGINT:C221(arrTransCount; 0)
		ARRAY TEXT:C222(arrNationality; 0)
		ARRAY TEXT:C222(arrIDNumber; 0)
		
	: ($formEvent=On Outside Call:K2:11)
		If (customerSearchTermPtr->="")  //user pressed the refresh button (didnt use search box)
			//resize arrays
			listbox_deleteAllRows(listBoxPointer)
			//find customers that have transaction in the given date range
			READ ONLY:C145([Registers:10])
			READ ONLY:C145([Customers:3])
			If (vBranchId#"")
				QUERY:C277([Registers:10]; [Registers:10]BranchID:39=vBranchId; *)
				QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2>=vFromDate; *)
				QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
			Else 
				QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate; *)
				QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
			End if 
			RELATE ONE SELECTION:C349([Registers:10]; [Customers:3])
			Check_CustomersTop100(listBoxPointer; ->arrCustomerFullName; ->arrDatePeriod; ->arrTransactionType; ->arrTotalTrans; ->arrTransCount; ->arrNationality; ->arrIDNumber)
			
		Else   //if user used the search box, "on outside call" is called for this form again. ignore and clear search box
			customerSearchTermPtr->:=""
		End if 
End case 