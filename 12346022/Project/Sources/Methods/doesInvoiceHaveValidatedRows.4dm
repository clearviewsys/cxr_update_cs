//%attributes = {}
// doesInvoiceHaveValidatedRows (invoiceID: text) : boolean
// returns true if any row in the invoice is validated 
// important to note: not all registers should be validated for this to return true; even 1 register is enough
// reason for this: we use this method to make sure that we don't void invoices that have validated rows in them (even 1 validated row)

// #ORDA

C_TEXT:C284($1; $invoiceID)
C_BOOLEAN:C305($0; $isValidated)

Case of 
	: (Count parameters:C259=0)  // for testing
		$invoiceID:="TTINV139837"
		
	: (Count parameters:C259=1)
		$invoiceID:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$isValidated:=False:C215

C_OBJECT:C1216($register; $registers)

$registers:=ds:C1482.Registers.query("InvoiceNumber = :1"; $invoiceID)
//[registers]accountID
If ($registers.length=0)
	$isValidated:=False:C215
Else 
	For each ($register; $registers)
		//[Registers]isValidated
		$isValidated:=($isValidated | $register.isValidated)  // any register that is validated is enough and will make the whole expression true
	End for each 
End if 

$0:=$isValidated