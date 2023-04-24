//%attributes = {}
showDateRangeTable(->[CashTransactions:36]; ->[CashTransactions:36]Date:5)  // this select the cash transactions first

RELATE MANY SELECTION:C340([CashInOuts:32]CashTransactionID:1)  //  we need to map the cash transactions to the correct cashinouts

orderByCashInOuts


