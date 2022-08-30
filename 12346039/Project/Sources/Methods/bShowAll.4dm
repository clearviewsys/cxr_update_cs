//%attributes = {"publishedWeb":true}
// bShowAll (->[table])
// e.g. bShowAll (->[customers])

C_POINTER:C301($tablePtr; $1)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

allRecords($tablePtr)
//highlightRecords (Current form table)
POST OUTSIDE CALL:C329(Current process:C322)