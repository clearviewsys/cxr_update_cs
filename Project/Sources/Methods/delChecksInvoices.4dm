//%attributes = {}
checkIfRelatedManyRecordExist(->[Registers:10]; ->[Registers:10]InvoiceNumber:10)
checkIfRelatedManyRecordExist(->[eWires:13]; ->[eWires:13]InvoiceNumber:29)
checkIfRelatedManyRecordExist(->[Wires:8]; ->[Wires:8]CXR_InvoiceID:12)
checkIfRelatedManyRecordExist(->[Cheques:1]; ->[Cheques:1]InvoiceID:5)
checkIfRelatedManyRecordExist(->[CashTransactions:36]; ->[CashTransactions:36]InvoiceID:7)
checkIfRelatedManyRecordExist(->[AccountInOuts:37]; ->[AccountInOuts:37]InvoiceID:4)
checkIfRelatedManyRecordExist(->[ItemInOuts:40]; ->[ItemInOuts:40]InvoiceID:4)
