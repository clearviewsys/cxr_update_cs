
C_LONGINT:C283($formEvent)
C_DATE:C307(vFromDate; vToDate)
C_TEXT:C284(vBranchID)
C_POINTER:C301(listBoxPointer)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Load:K2:1)
		OBJECT SET TITLE:C194(*; "ReportTitle"; "Transaction Summary")
		listBoxPointer:=OBJECT Get pointer:C1124(Object named:K67:5; "transactionSummary")
		ARRAY TEXT:C222(arrTimePeriod; 0)
		ARRAY REAL:C219(arrTotalTrans; 0)
		ARRAY REAL:C219(arrTransVolume; 0)
		ARRAY TEXT:C222(arrCustomerType; 0)
		ARRAY TEXT:C222(arrTransactionDesc; 0)
		
	: ($formEvent=On Outside Call:K2:11)
		listbox_deleteAllRows(listBoxPointer)
		
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
		Check_TransactionSummary(listBoxPointer; ->arrTimePeriod; ->arrTotalTrans; ->arrTransVolume; ->arrCustomerType; ->arrTransactionDesc)
End case 