C_TEXT:C284(vReceiptType; printNote)


Case of 
	: ([Invoices:5]isTransfer:42)
		vReceiptType:="Transfer Voucher"
	: ([Invoices:5]CustomerID:2=getSelfCustomerID)
		vReceiptType:="Internal Transaction Voucher"
	Else 
		vReceiptType:="SALES RECEIPT "+printNote
		
End case 