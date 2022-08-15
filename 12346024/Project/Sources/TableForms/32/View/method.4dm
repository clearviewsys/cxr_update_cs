//READ ONLY([Customers])
//read only([CashTransactions])
RELATE ONE:C42([CashInOuts:32]CashTransactionID:1)
RELATE ONE:C42([CashTransactions:36]CustomerID:10)