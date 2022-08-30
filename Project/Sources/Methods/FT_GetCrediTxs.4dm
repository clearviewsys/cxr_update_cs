//%attributes = {}
C_OBJECT:C1216($0; $registersCredit)
$registersCredit:=ds:C1482.Registers.query("InvoiceNumber == :1"; [Invoices:5]InvoiceID:1)

$registersCredit:=$registersCredit.query("CreditLocal > 0 ")
$registersCredit:=$registersCredit.query("isCancelled == false")
$registersCredit:=$registersCredit.query("isTransfer == false")
//$registersCredit:=$registersCredit.query("isExported == :1";$exported)

$registersCredit:=$registersCredit.orderBy("RegisterType desc")
$0:=$registersCredit