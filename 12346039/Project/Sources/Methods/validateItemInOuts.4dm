//%attributes = {}
checkUniqueKey(->[ItemInOuts:40]; ->[ItemInOuts:40]ItemInOutID:1; "ItemInOut ID")
//checkIfNullString(->[ItemInOuts]ItemInOut ID;"ItemInOut ID")
checkifRecordExists(->[Accounts:9]; ->[Accounts:9]AccountID:1; ->[ItemInOuts:40]accountID:13; "Account ID")
checkGreaterThan(->[ItemInOuts:40]Qty:8; "Qty"; 0)