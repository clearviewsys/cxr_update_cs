//%attributes = {}
PrependBranchPrefixTo(->[ItemInOuts:40]ItemInOutID:1; ->[ItemInOuts:40]BranchID:26)
PrependBranchPrefixTo(->[ItemInOuts:40]InvoiceID:4)
PrependBranchPrefixTo(->[ItemInOuts:40]registerID:5)

If (isCustomerNotSelfNOrWalkin([ItemInOuts:40]customerID:6))
	PrependBranchPrefixTo(->[ItemInOuts:40]customerID:6)
End if 
