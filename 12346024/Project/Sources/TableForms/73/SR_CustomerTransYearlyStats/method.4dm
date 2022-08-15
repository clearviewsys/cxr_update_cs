//author: Amir
//date: 3rd Nov 2018
//form method for customer transaction yearly report
C_LONGINT:C283($formEvent)
C_DATE:C307(vFromDate; vToDate)
C_LONGINT:C283(numRowsPerCustomer)
C_TEXT:C284(vBranchID)
C_POINTER:C301(customerSearchTermPtr)
C_POINTER:C301(listBoxPtr)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Load:K2:1)
		OBJECT SET TITLE:C194(*; "ReportTitle"; "Customer Yearly Statistics")
		customerSearchTermPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "customerSearchBox")
		listBoxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "customerStatsListBox2")
		ARRAY TEXT:C222(arrCustomerId; 0)
		ARRAY INTEGER:C220(arrYears; 0)
		ARRAY REAL:C219(arrTransactionVolume; 0)
		ARRAY REAL:C219(arrAvgBuys; 0)  //since buy and sell add up to same, just showing buy
		ARRAY REAL:C219(arrBuyQtys; 0)
		//finding how many rows we need per customer at most (maximum) for better efficiency. Used at method  calcCustmrTransYearlyStats()
		READ ONLY:C145([Registers:10])
		ALL RECORDS:C47([Registers:10])
		ORDER BY:C49([Registers:10]RegisterDate:2; >)
		numRowsPerCustomer:=Year of:C25(Current date:C33)-Year of:C25([Registers:10]RegisterDate:2)+1
	: ($formEvent=On Outside Call:K2:11)
		If (customerSearchTermPtr->="")  //user pressed the refresh button (didnt use search box)
			//resize arrays
			listbox_deleteAllRows(listBoxPtr)
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
			//find all customers that have transactions in given date range and branch
			RELATE ONE SELECTION:C349([Registers:10]; [Customers:3])
			//find all registers for selected customers
			RELATE MANY SELECTION:C340([Registers:10]CustomerID:5)
			//order registers for the algorithm that calculates the statistics
			ORDER BY:C49([Registers:10]; [Registers:10]CustomerID:5; >; [Registers:10]RegisterDate:2; >)
			calcCustmrTransYearlyStats(listBoxPtr; ->arrCustomerId; ->arrYears; ->arrTransactionVolume; ->arrAvgBuys; ->arrBuyQtys)
		Else   //if user used the search box, "on outside call" is called for this form again. ignore and clear search box
			customerSearchTermPtr->:=""
		End if 
End case 