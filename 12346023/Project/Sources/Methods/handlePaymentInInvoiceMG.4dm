//%attributes = {}
C_OBJECT:C1216($pickedWebeWire; $formObj)
C_LONGINT:C283($winref)
C_TEXT:C284($transactionType)

setInvoiceFieldsToVars

checkInit
checkIfNullString(->vReceivedOrPaid; "Received/Paid")
checkIfNullString(->vCustomerID; "Customer ID")
checkIfNullString(->vCurrency; "Currency")

If (isValidationConfirmed)
	
	PUSH RECORD:C176([Invoices:5])
	
	If (vReceivedOrPaid="Paid")
		$transactionType:="Send"
	Else 
		$transactionType:="Receive"
	End if 
	
	$pickedWebeWire:=pickMGWebEwireForInvoice(vCustomerID; $transactionType)
	
	If ($pickedWebeWire#Null:C1517)
		
		// we are using object instead of entity because we are in the middle of multilevel transaction
		// and saving WebeWire using ORDA locks the record for classic 4D commands
		
		$formObj:=$pickedWebeWire.toObject()
		
		$winref:=Open form window:C675([WebEWires:149]; "MG_PayReceive")
		DIALOG:C40([WebEWires:149]; "MG_PayReceive"; $formObj)
		CLOSE WINDOW:C154
		
		If (OK=1)
			READ WRITE:C146([WebEWires:149])
			QUERY:C277([WebEWires:149]; [WebEWires:149]WebEwireID:1=$formObj.WebEwireID)
			UTIL_Entity2Record($formObj; ->[WebEWires:149])
			createRegistersOfMGWebeWire(True:C214; vInvoiceNumber; INV_vNextAccountID)
			
			// "clear" in Invoice
			clearInvoiceEnterableVars
			GOTO OBJECT:C206(*; "vReceivedPaid")
			OBJECT SET HELP TIP:C1181(*; "vReceivedPaid"; "Press B for Buy or S for Sell")
			handleVecPaymentPullDown(->vecPaymentMethod; 1)
			
		End if 
		
	End if 
	
	POP RECORD:C177([Invoices:5])
	
	setInvoiceVarsToFields  // restore variable values AFTER POP
	
	relateManyRegistersForInvoice
	
End if 
