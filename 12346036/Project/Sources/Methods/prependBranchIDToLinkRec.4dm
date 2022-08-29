//%attributes = {}
PrependBranchPrefixTo(->[Links:17]LinkID:1; ->[Links:17]BranchID:38)

If (isCustomerNotSelfNOrWalkin([Links:17]CustomerID:14))
	PrependBranchPrefixTo(->[Links:17]CustomerID:14)
End if 



