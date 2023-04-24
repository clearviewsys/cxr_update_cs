//%attributes = {}
//QUERY([AccountInOuts];[AccountInOuts]AccountInOutID="ACC@")
//updateTableUsingMethod (->[AccountInOuts];"prependBranchIDToAccountIORec";False)

prependBIDToTable(->[AccountInOuts:37]; ->[AccountInOuts:37]AccountInOutID:1; "prependBranchIDToAccountIORec")

