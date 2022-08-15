//%attributes = {}
PrependBranchPrefixTo(->[Cheques:1]ChequeID:1; ->[Cheques:1]BranchID:25)
PrependBranchPrefixTo(->[Cheques:1]InvoiceID:5)
PrependBranchPrefixTo(->[Cheques:1]RegisterID:6)

If (isCustomerNotSelfNOrWalkin([Cheques:1]CustomerID:2))
	PrependBranchPrefixTo(->[Cheques:1]CustomerID:2)
End if 


