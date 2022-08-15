

C_OBJECT:C1216($entity)

$entity:=New object:C1471
$entity:=ds:C1482.WebEWires.query("paymentInfo.invoiceID == :1"; [Invoices:5]InvoiceID:1)

If ($entity.length=1)
	Self:C308->:="MG Ref: "+$entity[0].paymentInfo.result.referenceNumber
Else 
	Self:C308->:=""
End if 
