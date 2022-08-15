C_LONGINT:C283($iRecNum)


Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If ([Bookings:50]invoiceID:19="")
			OBJECT SET ENABLED:C1123(Self:C308->; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		$iRecNum:=Record number:C243([Bookings:50])
		
		setNextCustomer([Bookings:50]CustomerID:2)
		newRecordInvoices
		initNextCustomer
		
		GOTO RECORD:C242([Bookings:50]; $iRecNum)
		
		C_OBJECT:C1216($invoice)
		If ([Bookings:50]isHonored:18) & ([Bookings:50]invoiceID:19#"")  // check if the invoice was successfully created
			$invoice:=ds:C1482.Invoices.query("InvoiceID =:1"; [Bookings:50]invoiceID:19)
			If ($invoice.length=0)  // invoice not successfully created
				[Bookings:50]isHonored:18:=False:C215
			End if 
		End if 
	Else 
		
End case 