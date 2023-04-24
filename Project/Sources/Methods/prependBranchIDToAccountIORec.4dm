//%attributes = {}
PrependBranchPrefixTo(->[AccountInOuts:37]AccountInOutID:1; ->[AccountInOuts:37]BranchID:18)
PrependBranchPrefixTo(->[AccountInOuts:37]InvoiceID:4)
PrependBranchPrefixTo(->[AccountInOuts:37]RegisterID:5)

If (isCustomerNotSelfNOrWalkin([AccountInOuts:37]CustomerID:2))
	PrependBranchPrefixTo(->[AccountInOuts:37]CustomerID:2)
End if 

