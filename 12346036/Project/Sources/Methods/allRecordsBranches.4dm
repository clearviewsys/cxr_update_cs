//%attributes = {}
// allRecordsBranches({isInactive})
// by default it shows all branches
// if sent false, it will only show active branches


C_BOOLEAN:C305($isInactive; $1)


Case of 
	: (Count parameters:C259=0)
		ALL RECORDS:C47([Branches:70])
	: (Count parameters:C259=1)
		QUERY:C277([Branches:70]; [Branches:70]isInactive:18=$1)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

orderByBranches