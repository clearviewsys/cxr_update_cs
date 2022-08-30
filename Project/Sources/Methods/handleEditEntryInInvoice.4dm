//%attributes = {}
// handlePaymentInInvoiceForTable(->[ManyTABLE];->[ManyTable]invoiceNofield;->isReceivedField;isReceived; "FormName";)
// this method is called from within Invoice buttons


setInvoiceFieldsToVars
PUSH RECORD:C176([Invoices:5])
C_POINTER:C301($tablePtr)
//C_BOOLEAN($isReceived)
C_TEXT:C284($formName)
LOAD RECORD:C52([Registers:10])
If (([Registers:10]InternalTableNumber:17>0) & ([Registers:10]isTransfer:3=False:C215))  // cannot edit transfers TB Jul 4/2018
	$tablePtr:=Table:C252([Registers:10]InternalTableNumber:17)
	If ([Registers:10]isReceived:13)
		$formName:="receive"
	Else 
		$formName:="pay"
	End if 
	
	
	READ WRITE:C146($tablePtr->)
	
	QUERY:C277($tablePtr->; Field:C253([Registers:10]InternalTableNumber:17; 1)->=[Registers:10]InternalRecordID:18)  // look for the related 
	// because we may have one record for the receipt and one for the payment
	
	If (Records in selection:C76($tablePtr->)>0)  // found a related record therefore edit that record
		modifyRecordInInvoice($tablePtr; $formName)
	End if 
	UNLOAD RECORD:C212($tablePtr->)
	READ ONLY:C145($tablePtr->)
	POP RECORD:C177([Invoices:5])
	setInvoiceVarsToFields  // restore variable values AFTER POP
	RELATE MANY:C262([Invoices:5]InvoiceID:1)  // load the registers linked
	
	REDRAW WINDOW:C456  //12/8/17 IBB
End if 