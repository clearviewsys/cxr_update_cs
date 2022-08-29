//%attributes = {}

PrependBranchPrefixTo(->[LinkedDocs:4]LinkedDocID:12)  //ibb added

If (isCustomerNotSelfNOrWalkin([LinkedDocs:4]CustomerID:1))
	PrependBranchPrefixTo(->[LinkedDocs:4]CustomerID:1)
End if 


