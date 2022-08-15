//%attributes = {}
PrependBranchPrefixTo(->[Invoices:5]InvoiceID:1; ->[Invoices:5]BranchID:53)

If (isCustomerNotSelfNOrWalkin([Invoices:5]CustomerID:2))
	PrependBranchPrefixTo(->[Invoices:5]CustomerID:2)
End if 
