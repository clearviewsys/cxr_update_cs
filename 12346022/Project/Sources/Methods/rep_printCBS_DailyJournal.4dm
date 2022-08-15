//%attributes = {"shared":true}
C_DATE:C307(vFromDate; vToDate)
vToDate:=Current date:C33

requestDateRange
If (OK=1)
	QUERY:C277([Registers:10]; [Registers:10]isTrade:38=True:C214; *)
	QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2>=vFromDate; *)
	QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
	If (Records in selection:C76([Registers:10])>0)
		printSelectionUsingPrinter(->[Registers:10]; "rep_CBS_DailyJournal"; getClientDefaultPrinterName; 0)
	End if 
End if 
