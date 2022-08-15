//%attributes = {}
relateMany(->[CashInOuts:32]; ->[CashInOuts:32]CashTransactionID:1; ->[CashTransactions:36]CashTransactionID:1)
ORDER BY:C49([CashInOuts:32]; [CashInOuts:32]Denomination:7; <; [CashInOuts:32]QtyIN:8; <; [CashInOuts:32]QtyOut:9; <)
