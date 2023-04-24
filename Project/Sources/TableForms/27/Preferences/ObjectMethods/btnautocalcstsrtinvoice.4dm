C_LONGINT:C283($iSeqNo)

C_LONGINT:C283($iSeqNo)

If (True:C214)
	$iSeqNo:=UTIL_resetSequenceNum(->[Invoices:5])
	[ServerPrefs:27]startInvoiceNumber:1:=UTIL_getSequencePadding(->[Invoices:5])
Else 
	C_TEXT:C284(vInvNumber)
	getLastOrderedRecord(->[Invoices:5]; ->[Invoices:5]InvoiceID:1; ->vInvNumber)
	[ServerPrefs:27]startInvoiceNumber:1:=Num:C11(vInvNumber)-Sequence number:C244([Invoices:5])+1
	CLEAR VARIABLE:C89(vInvNumber)
End if 