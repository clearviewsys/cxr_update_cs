C_LONGINT:C283(CBQUERYSELECTION)

If (CBQUERYSELECTION=1)
	QUERY SELECTION:C341([Invoices:5]; [Invoices:5]CreatedByUserID:19=getApplicationUser)
Else 
	QUERY:C277([Invoices:5]; [Invoices:5]CreatedByUserID:19=getApplicationUser)
End if 