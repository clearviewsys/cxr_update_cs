C_LONGINT:C283($0)

$0:=0
If (isTriggerEnabled)
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			If ([Invoices:5]InvoiceID:1="")
				[Invoices:5]InvoiceID:1:=makeInvoiceID  // for first time
			End if 
			
			If ([Invoices:5]InvoiceSerial:73=0)  // if there are no current invoice serial #, then assign one
				[Invoices:5]InvoiceSerial:73:=getTableNextSerialNo(->[Invoices:5])  // add the invoice number sequence generator (added in version 3.551+)
				setInvoiceAutoComment
			End if 
			
			[Invoices:5]CreationDate:13:=Current date:C33
			[Invoices:5]CreationTime:14:=Current time:C178
			[Invoices:5]CreatedByUserID:19:=Current user:C182  // now that we use set user alias we have good info here
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			//setDateTimeUserForced (->[Invoices]ModificationDate;->[Invoices]ModificationTime)` turned off in version 3.551+
			setInvoiceAutoComment
			
			[Invoices:5]ModificationDate:17:=Current date:C33
			[Invoices:5]ModificationTime:18:=Current time:C178
			[Invoices:5]ModifiedByUserID:20:=Current user:C182
			
			If ([Invoices:5]InvoiceSerial:73=0)  // if there are no current invoice serial #, then assign one @ibb added 1/25/23
				[Invoices:5]InvoiceSerial:73:=getTableNextSerialNo(->[Invoices:5])  // add the invoice number sequence generator (added in version 3.551+)
				setInvoiceAutoComment
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	
	writeLogTrigger([Invoices:5]InvoiceID:1; $0)
End if 


AUDIT_Trigger
TriggerSync