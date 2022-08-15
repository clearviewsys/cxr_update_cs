//%attributes = {}
deleteRelatedManyRecords(->[CashInOuts:32]; ->[CashInOuts:32]CashTransactionID:1)  // deletes the cashinouts records

deleteRelatedOneRecords(->[CashTransactions:36]; ->[CashTransactions:36]registerID:8; ->[Registers:10])  // deletes the register

