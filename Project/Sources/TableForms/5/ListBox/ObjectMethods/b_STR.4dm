
C_TEXT:C284($menu; $item)

$menu:=Create menu:C408
APPEND MENU ITEM:C411($menu; "All STR Transactions")
SET MENU ITEM PARAMETER:C1004($menu; -1; "All")
APPEND MENU ITEM:C411($menu; "STR Period Report")
SET MENU ITEM PARAMETER:C1004($menu; -1; "Period")


$item:=Dynamic pop up menu:C1006($menu)


Case of 
	: ($item="All")
		QUERY:C277([Invoices:5]; [Invoices:5]isSuspicious:30=True:C214; *)
		QUERY:C277([Invoices:5];  & ; [Invoices:5]isAMLReported:45=False:C215)
		
		If (Records in selection:C76([Invoices:5])=0)
			myAlert("No STR transactions found.")
		End if 
		
	: ($item="Period")
		If (isUserAllowedToPrintReports)
			vFromDate:=Current date:C33
			vToDate:=Current date:C33
			requestDateRange
			
			If (OK=1)
				QUERY:C277([Invoices:5]; [Invoices:5]isSuspicious:30=True:C214; *)
				QUERY:C277([Invoices:5];  & ; [Invoices:5]invoiceDate:44>=vFromDate; *)
				QUERY:C277([Invoices:5];  & ; [Invoices:5]invoiceDate:44<=vToDate)
				
				If (Records in selection:C76([Invoices:5])>0)
					printInvoicesSTR
				Else 
					printNoRecordsFound("Suspicious Transactions")
				End if 
				
				
			End if 
			
		Else 
			myAlert("You are not allowed to print this report.")
		End if 
	Else 
		
End case 