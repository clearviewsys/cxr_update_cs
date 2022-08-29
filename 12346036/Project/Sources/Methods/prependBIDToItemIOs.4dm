//%attributes = {}
//QUERY([ItemInOuts];[ItemInOuts]ItemInOutID="ITE@")
//PrependBranchPrefixTo (->[ItemInOuts]ItemInOutID;->[ItemInOuts]BranchID)

prependBIDToTable(->[ItemInOuts:40]; ->[ItemInOuts:40]ItemInOutID:1; "prependBranchIDToItemIORec")

