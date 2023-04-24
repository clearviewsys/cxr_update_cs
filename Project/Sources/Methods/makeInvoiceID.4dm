//%attributes = {}
C_TEXT:C284($0; $id)
C_LONGINT:C283($recNum; $i; $seq)
C_BOOLEAN:C305($doAutoCorrect)


$doAutoCorrect:=Choose:C955(getKeyValue("invoice.number.autocorrect"; "true")="true"; True:C214; False:C215)

$i:=0
Repeat 
	$id:=createSerializedID(->[Invoices:5]; <>startInvoiceNumber+$i)
	$recNum:=Find in field:C653([Invoices:5]InvoiceID:1; $id)
	$i:=$i+1
Until (($recNum=-1) | ($doAutoCorrect=False:C215))

If ($i>1)
	$seq:=Num:C11($id)-<>startInvoiceNumber  //+1
	SET DATABASE PARAMETER:C642([Invoices:5]; Table sequence number:K37:31; $seq)
	UTIL_Log("sequenceException"; "Invoice number incremented to: "+String:C10($seq))
End if 

$0:=$id