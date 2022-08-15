//%attributes = {}
// isInvoiceReconciled (text) : boolean
// return if one of the related [registers] record of the invoice has been reconciled
//#ORDA

C_TEXT:C284($1; $tInvoiceNo)
C_BOOLEAN:C305($0)
C_OBJECT:C1216($registers)
$tInvoiceNo:=$1

$registers:=ds:C1482.Registers.query("InvoiceNumber =:1 & isValidated =:2"; $tInvoiceNo; True:C214)
If ($registers.length>=1)
	$0:=True:C214
Else 
	$0:=False:C215
End if 
