//%attributes = {}
PrependBranchPrefixTo(->[eWires:13]eWireID:1; ->[eWires:13]BranchID:50)
PrependBranchPrefixTo(->[eWires:13]InvoiceNumber:29)
PrependBranchPrefixTo(->[eWires:13]RegisterID:24)

If (isCustomerNotSelfNOrWalkin([eWires:13]CustomerID:15))
	PrependBranchPrefixTo(->[eWires:13]CustomerID:15)
End if 
