//%attributes = {}
// handlePaymentInInvoice(->[ManyTABLE];->[ManyTable]invoiceNofield;->isReceivedField;isPaid;allowMultipleEntries)
// this method is called from within Invoice buttons
C_POINTER:C301($tablePtr; $1; $2; $3; $invoiceNoFieldPtr; $isReceivedFieldPtr; $isPaidFieldPtr)
C_BOOLEAN:C305($isPaid; $allowMultipleEntries; $4; $5)
C_TEXT:C284($formName)

$tablePtr:=$1
$invoiceNoFieldPtr:=$2
$isPaidFieldPtr:=$3
$isPaid:=$4
$allowMultipleEntries:=$5

setInvoiceFieldsToVars

checkInit
checkIfNullString(->vReceivedOrPaid; "Received/Paid")
checkIfNullString(->vCustomerID; "Customer ID")
checkIfNullString(->vCurrency; "Currency")
checkGreaterThan(->vAmount; "Amount"; 0; "warn")


If (isValidationConfirmed)
	PUSH RECORD:C176([Invoices:5])
	If ($isPaid)
		$formName:="Pay"
	Else 
		$formName:="Receive"
	End if 
	
	READ WRITE:C146($tablePtr->)
	If ($allowMultipleEntries)  // allow more than one entry of such type in the invoice (eg: more than 1 cheque can be paid in the same invoice)
		newRecord($tablePtr; False:C215; $formName)
	Else 
		QUERY:C277($tablePtr->; $InvoiceNoFieldPtr->=vInvoiceNumber)  // look for the linked record in the external many table (eg: cheques)
		// because we may have one record for the receipt and one for the payment
		QUERY SELECTION:C341($tablePtr->; $isPaidFieldPtr->=$isPaid)  // search in the selection for all payments that are received(or paid)
		If (Records in selection:C76($tablePtr->)>0)  // found a related record therefore edit that record
			modifyRecord($tablePtr; $formName)
		Else 
			newRecord($tablePtr; False:C215; $formName)
		End if 
	End if 
	UNLOAD RECORD:C212($tablePtr->)
	READ ONLY:C145($tablePtr->)
	POP RECORD:C177([Invoices:5])
	setInvoiceVarsToFields  // restore variable values AFTER POP
	relateManyRegistersForInvoice
End if 