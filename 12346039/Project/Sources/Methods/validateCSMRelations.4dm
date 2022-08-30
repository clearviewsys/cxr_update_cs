//%attributes = {}
//checkUniqueKey (->[CSMRelations];->[CSMRelations]CSMRelationID;"CSMRelationID")
checkIfNullString(->[CSMRelations:89]CustomerID1:2; "Customer ID 1")
checkIfNullString(->[CSMRelations:89]CustomerID2:3; "Customer ID 2")

If (([CSMRelations:89]isAuthorized:15=0) & ([CSMRelations:89]isDirectorOf:9=0) & ([CSMRelations:89]isShareholderOf:10=0))  // not a director, or shareholder, or signing authority
	checkIfNullString(->[CSMRelations:89]relationType:6; "Relation Type")
End if 
