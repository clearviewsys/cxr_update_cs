//%attributes = {}
// getCleitnInvoiceEntryForm({ClientName}) -> formName
// get current client Cheque printer name

C_TEXT:C284($0; $form; $default)
selectClientPrefsRecord
$default:="Entry"
$form:=$default

If (Records in selection:C76([ClientPrefs:26])=1)
	If ([ClientPrefs:26]InvoiceEntryForm:23#"")
		$form:=[ClientPrefs:26]InvoiceEntryForm:23
	End if 
End if 

$0:=$form