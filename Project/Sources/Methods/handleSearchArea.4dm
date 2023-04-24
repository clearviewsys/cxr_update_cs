//%attributes = {}
// handleSearchArea ({->[table]})

C_POINTER:C301($tablePtr; $1)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
		
	: (Count parameters:C259=1)
		$tablePtr:=$1
		
	Else 
		assertInvalidNumberOfParams
End case 

EXECUTE METHOD:C1007("search"+Table name:C256($tablePtr))
POST OUTSIDE CALL:C329(Current process:C322)
GOTO OBJECT:C206(*; "searchArea")

//getbuild

