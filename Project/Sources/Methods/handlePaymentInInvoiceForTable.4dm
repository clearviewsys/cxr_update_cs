//%attributes = {}
// handlePaymentInInvoiceForTable(->[ManyTABLE];->[ManyTable]invoiceNofield;->isReceivedField;isPaid;allowMultipleEntries)

// this method is called from within Invoice buttons

C_POINTER:C301($tablePtr; $1; $2; $3; $invoiceNoFieldPtr; $isReceivedFieldPtr; $isPaidFieldPtr)
C_BOOLEAN:C305($isReceived; $allowMultipleEntries; $5; $isPaid)
C_TEXT:C284($formName)

$tablePtr:=$1
$invoiceNoFieldPtr:=$2
$isPaidFieldPtr:=$3
$isPaid:=$4
$allowMultipleEntries:=$5

setInvoiceFieldsToVars

checkInit
checkIfNullString(->[Invoices:5]CustomerID:2; "Customer ID")
checkIfNullString(->[Invoices:5]fromCurrency:3; "From Currency")
checkIfNullString(->[Invoices:5]toCurrency:8; "To Currency")
checkGreaterThan(->[Invoices:5]fromAmount:25; "From Amount"; 0; "warn")
checkGreaterThan(->[Invoices:5]toAmount:26; "To Amount"; 0; "warn")


If (Not:C34($isPaid))
	checkGreaterThan(->vRemainReceive; "Remaining balance to receive"; 0; "warn")
Else 
	checkGreaterThan(->vRemainPaid; "Remaining balance to pay"; 0; "warn")
End if 


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
		QUERY:C277($tablePtr->; $InvoiceNoFieldPtr->=[Invoices:5]InvoiceID:1)  // look for the linked record in the external many table (eg: cheques)
		
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
	
	RELATE MANY:C262([Invoices:5]InvoiceID:1)  // load the registers linked
	
End if 