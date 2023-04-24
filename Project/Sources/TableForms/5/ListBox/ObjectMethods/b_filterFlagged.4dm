
If (Form:C1466.filterSelection=1)
	QUERY SELECTION:C341([Invoices:5]; [Invoices:5]isFlagged:41=True:C214)
Else 
	QUERY:C277([Invoices:5]; [Invoices:5]isFlagged:41=True:C214)
End if 