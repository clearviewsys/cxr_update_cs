//%attributes = {}
setInvoiceFieldstoVars2

// the following part reassigns the registers to the current date and customer ID
If (False:C215)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	QUERY:C277([Registers:10]; [Registers:10]InvoiceNumber:10=[Invoices:5]InvoiceID:1)
	READ WRITE:C146([Registers:10])
	FIRST RECORD:C50([Registers:10])
	C_LONGINT:C283($i)
	For ($i; 1; Records in selection:C76([Registers:10]))
		LOAD RECORD:C52([Registers:10])
		If (([Registers:10]CustomerID:5#[Invoices:5]CustomerID:2) & ([Registers:10]InternalRecordID:18#"") & (Old:C35([Registers:10]CustomerID:5)#[Registers:10]CustomerID:5))
			myAlert("Please double check customer ID in table "+getElegantTableNameByNum([Registers:10]InternalTableNumber:17))
		End if 
		[Registers:10]CustomerID:5:=[Invoices:5]CustomerID:2
		[Registers:10]RegisterDate:2:=[Invoices:5]invoiceDate:44
		SAVE RECORD:C53([Registers:10])
		NEXT RECORD:C51([Registers:10])
	End for 
End if 
// validateinvoices
handleSaveButton(->[Invoices:5]; ->[Invoices:5]BranchID:53; ->[Invoices:5]CreationDate:13; ->[Invoices:5]CreationTime:14; ->[Invoices:5]CreatedByUserID:19; ->[Invoices:5]ModificationDate:17; ->[Invoices:5]ModificationTime:18; ->[Invoices:5]ModifiedByUserID:20; ->[Invoices:5]modBranchID:94)

If (OK=1)
	C_OBJECT:C1216($entity)
	C_LONGINT:C283($error)
	$entity:=New object:C1471
	$entity:=ds:C1482.WebEWires.query("paymentInfo.invoiceID == :1"; [Invoices:5]InvoiceID:1)
	If ($entity.length=1)  //
		$error:=sendNotificationEmailForInvoice  //auto send for web created orders
		If ($error=0)
			iH_Notify("Alert"; "Notification email has been sent to: "+[Invoices:5]CustomerFullName:54; 5)
		End if 
	End if 
End if 

//disabled b/c was commiting transactions before a final invoice save was called in newRecord
// if validation in handleSaveButton fails then transaction is committed but user is back in invoice detail form
// if user now cancels the invoice... the registers have been saved and orphaned

//7/29/16

//While (In transaction)
//validatetransaction
//End while 
