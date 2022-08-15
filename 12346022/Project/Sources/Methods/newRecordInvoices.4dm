//%attributes = {"shared":true}
C_TEXT:C284(vLastCustomerID; vCustomerID)
C_BOOLEAN:C305($repeat; $autoPrint; $previewInvoice)

selectClientPrefsRecord

$repeat:=[ClientPrefs:26]repeatNewInvoice:12
$autoPrint:=[ClientPrefs:26]doPrintInvoiceAfterSave:13
$previewInvoice:=[ClientPrefs:26]previewInvoiceAfterSave:11

If (Not:C34(isUserSignedInWithCashRegister) & <>doAskSigningWithTill)
	myAlert("You are not signed-in to any tills. Some cash accounts may not be available to "+"you unless you sign in.")
	displayList_(->[CashRegisters:33])  // do not use displaylist cash registers because the process doesn't wait andcreates an ifinite loop
End if 

Repeat 
	
	newRecord(->[Invoices:5]; False:C215; getClientInvoiceEntryForm)
	C_REAL:C285(vAmount)
	LOAD RECORD:C52([Invoices:5])  // lock this record
	
	If ((OK=1) & ($autoPrint))
		RELATE MANY:C262([Invoices:5]InvoiceID:1)
		ORDER BY:C49([Registers:10]; [Registers:10]RegisterID:1)
		printThisInvoice
	End if 
	
	If ((OK=1) & ($previewInvoice))
		//displaySelectedRecords (->[Invoices])
		C_LONGINT:C283($winRef)
		$winRef:=openFormWindow(->[Invoices:5]; "view")
		CLOSE WINDOW:C154($winRef)
	Else 
		$repeat:=False:C215
	End if 
	UNLOAD RECORD:C212([Invoices:5])  // unlock this record
	
Until ($repeat=False:C215)

