//author: Amir
//date: 11th September 2018
//form method for customer transaction report
C_LONGINT:C283($formEvent)
C_DATE:C307(vFromDate; vToDate)
C_TEXT:C284(vBranchID)
C_POINTER:C301(customerSearchTermPtr)  //for customer search box
C_POINTER:C301(listBoxPointer)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Load:K2:1)
		OBJECT SET TITLE:C194(*; "ReportTitle"; "Customer Transaction Statistics")
		customerSearchTermPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "customerSearchBox")
		listBoxPointer:=OBJECT Get pointer:C1124(Object named:K67:5; "customerStatsListBox")
		ARRAY TEXT:C222(arrCustomerIdAndNames; 0)
		ARRAY TEXT:C222(arrTransTypes; 0)
		ARRAY TEXT:C222(arrDescriptions; 0)
		ARRAY REAL:C219(arrTotalBuys; 0)
		ARRAY REAL:C219(arrTotalSells; 0)
		ARRAY REAL:C219(arrAvgBuys; 0)
		ARRAY REAL:C219(arrAvgSells; 0)
		ARRAY REAL:C219(arrBuyQtys; 0)
		ARRAY REAL:C219(arrSellQtys; 0)
		
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
			calcCustmrTransactStats(listBoxPointer; ->arrCustomerIdAndNames; ->arrTransTypes; ->arrDescriptions; ->arrTotalBuys; ->arrTotalSells; ->arrAvgBuys; ->arrAvgSells; ->arrBuyQtys; ->arrSellQtys)
		Else   //if user used the search box, "on outside call" is called for this form again. ignore and clear search box
			customerSearchTermPtr->:=""
		End if 
End case 