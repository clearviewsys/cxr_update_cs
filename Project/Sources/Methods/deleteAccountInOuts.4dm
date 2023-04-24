//%attributes = {}
//deleteRelatedManyRecords(->[manyTable];->[manyTable]AccountInOutID)

//deleteRelatedOneRecords(->[AccountInOuts];->[AccountInOuts]AccountInOutID;->[oneTable])

deleteRelatedOneRecords(->[AccountInOuts:37]; ->[AccountInOuts:37]RegisterID:5; ->[Registers:10])  // deletes the register

