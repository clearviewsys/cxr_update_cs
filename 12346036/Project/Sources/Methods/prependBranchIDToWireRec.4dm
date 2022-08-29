//%attributes = {}
PrependBranchPrefixTo(->[Wires:8]CXR_WireID:1; ->[Wires:8]BeneficiaryBranchID:33)
PrependBranchPrefixTo(->[Wires:8]CXR_InvoiceID:12)
PrependBranchPrefixTo(->[Wires:8]CXR_RegisterID:13)

If (isCustomerNotSelfNOrWalkin([Wires:8]CustomerID:2))
	PrependBranchPrefixTo(->[Wires:8]CustomerID:2)
End if 