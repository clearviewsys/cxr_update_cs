//%attributes = {}
PrependBranchPrefixTo(->[WireTemplates:42]WireTemplateID:1; ->[WireTemplates:42]BranchID:20)

If (isCustomerNotSelfNOrWalkin([WireTemplates:42]CustomerID:2))
	PrependBranchPrefixTo(->[WireTemplates:42]CustomerID:2)
End if 

