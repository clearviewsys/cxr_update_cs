//%attributes = {}
// isInvoiceCashOnly (invoiceID: text) : boolean
// returns true if all registers in the invoice are cash only
// #ORDA

C_TEXT:C284($1; $invoiceID)
C_BOOLEAN:C305($0; $isCashOnly; $isCash)

Case of 
	: (Count parameters:C259=0)  // for testing
		$invoiceID:="TTINV140114"
		
	: (Count parameters:C259=1)
		$invoiceID:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$isCashOnly:=True:C214

C_OBJECT:C1216($register; $registers)

$registers:=ds:C1482.Registers.query("InvoiceNumber = :1"; $invoiceID)
//[registers]accountID
If ($registers.length=0)
	$isCashOnly:=False:C215
Else 
	For each ($register; $registers)
		$isCashOnly:=($isCashOnly & $register.isCash)  // all registers must be cash only
	End for each 
End if 

$0:=$isCashOnly