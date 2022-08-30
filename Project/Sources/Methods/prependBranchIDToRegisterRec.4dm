//%attributes = {}
PrependBranchPrefixTo(->[Registers:10]RegisterID:1; ->[Registers:10]BranchID:39)  // update register id
PrependBranchPrefixTo(->[Registers:10]InvoiceNumber:10)  // update the invoiceID
PrependBranchPrefixTo(->[Registers:10]InternalRecordID:18)  // update the external reference

If (isCustomerNotSelfNOrWalkin([Registers:10]CustomerID:5))
	PrependBranchPrefixTo(->[Registers:10]CustomerID:5)  // update the customerID
	
End if 
