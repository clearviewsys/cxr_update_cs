//author: Amir
//date: 13th Dec 2018
C_LONGINT:C283($formEvent)
C_DATE:C307(vFromDate; vToDate)
C_TEXT:C284(vBranchID)
C_POINTER:C301(isSettledChkbox)
C_POINTER:C301(listBoxPointer)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Load:K2:1)
		OBJECT SET TITLE:C194(*; "ReportTitle"; "Bookings Summary")
		//arrays for summary page
		ARRAY TEXT:C222(arrCurrencyCode; 0)
		ARRAY TEXT:C222(arrCurrencyName; 0)
		ARRAY REAL:C219(arrTotalBuy; 0)
		ARRAY REAL:C219(arrTotalSell; 0)
		ARRAY PICTURE:C279(arrFlags; 0)
		ARRAY LONGINT:C221(arrNoOfBuy; 0)
		ARRAY LONGINT:C221(arrNoOfSell; 0)
		listBoxPointer:=OBJECT Get pointer:C1124(Object named:K67:5; "bookingSummaryListBox")
		isSettledChkbox:=OBJECT Get pointer:C1124(Object named:K67:5; "isSettledChkbox")
	: ($formEvent=On Outside Call:K2:11)
		listbox_deleteAllRows(listBoxPointer)
		
		READ ONLY:C145([Bookings:50])
		QUERY:C277([Bookings:50]; [Bookings:50]ValueDate:26>=vFromDate; *)
		QUERY:C277([Bookings:50];  & ; [Bookings:50]ValueDate:26<=vToDate)
		If (isSettledChkbox->=1)  //is settled means is confirmed and is honored
			QUERY SELECTION:C341([Bookings:50]; [Bookings:50]isConfirmed:15=True:C214)
			QUERY SELECTION:C341([Bookings:50]; [Bookings:50]isHonored:18=True:C214)
		End if 
		If (vBranchID#"")
			QUERY SELECTION:C341([Bookings:50]; [Bookings:50]BranchID:25=vBranchID)
		End if 
		ORDER BY:C49([Bookings:50]; [Bookings:50]Currency:10; >)
		calculateBookingSummaryReport(->arrCurrencyCode; ->arrTotalBuy; ->arrTotalSell; listBoxPointer; ->arrFlags; ->arrCurrencyName; ->arrNoOfBuy; ->arrNoOfSell)
End case 
