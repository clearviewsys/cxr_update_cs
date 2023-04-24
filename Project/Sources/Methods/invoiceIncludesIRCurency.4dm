//%attributes = {}
// invoiceIncludesIRCurency ($invoiceNum)

C_TEXT:C284($1; $invoiceNum)
C_BOOLEAN:C305($0; $isIranRelated)

$invoiceNum:=$1
$isIranRelated:=False:C215

C_OBJECT:C1216($reg; $registers)
$registers:=ds:C1482.Registers.query("InvoiceNumber == :1"; $invoiceNum)

For each ($reg; $registers)
	If (($reg.Currency="TOM") | ($reg.Currency="IRR"))
		$isIranRelated:=True:C214
	End if 
End for each 

$0:=$isIranRelated
