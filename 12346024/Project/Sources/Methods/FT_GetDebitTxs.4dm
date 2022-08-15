//%attributes = {}
C_OBJECT:C1216($0; $registersDebit)

$registersDebit:=ds:C1482.Registers.query("InvoiceNumber == :1"; [Invoices:5]InvoiceID:1)
//$registersDebit:=$registersDebit.query("CreationDate = :1";initialDate)
$registersDebit:=$registersDebit.query("DebitLocal > 0 ")
$registersDebit:=$registersDebit.query("isCancelled == false")
$registersDebit:=$registersDebit.query("isTransfer == false")
//$registersDebit:=$registersDebit.query("isExported == :1";$exported)
$registersDebit:=$registersDebit.orderBy("RegisterType asc,")
$0:=$registersDebit