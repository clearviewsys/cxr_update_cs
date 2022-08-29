C_LONGINT:C283($found)


If (Form event code:C388=On Data Change:K2:15)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $found)
	QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[Invoices:5]linkedToInvoice:93)
	If ($found>0)
		//[Invoices]lineedToInvoice
		OBJECT SET VISIBLE:C603(*; "Linked"; True:C214)
		
	Else 
		BEEP:C151
		myAlert("This invoice does not exist")
		[Invoices:5]linkedToInvoice:93:=""
		OBJECT SET VISIBLE:C603(*; "Linked"; False:C215)
		
	End if 
	
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
End if 