//%attributes = {}
PrependBranchPrefixTo(->[CashTransactions:36]CashTransactionID:1; ->[CashTransactions:36]BranchID:20)
PrependBranchPrefixTo(->[CashTransactions:36]InvoiceID:7)
PrependBranchPrefixTo(->[CashTransactions:36]registerID:8)

If (isCustomerNotSelfNOrWalkin([CashTransactions:36]CustomerID:10))
	PrependBranchPrefixTo(->[CashTransactions:36]CustomerID:10)
End if 