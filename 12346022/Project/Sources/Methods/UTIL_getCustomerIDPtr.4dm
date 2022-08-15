//%attributes = {}
// Method: UTIL_GET_TABLE_PK
// Returns pointer to primary key field(s) of a given table
//
// Parameters:
// $1 - Pointer to table
// $2 - Pointer to an array of pointers to contain primary key fields (OPTIONAL)
// $0 - Returns pointer to field that is primary key
C_POINTER:C301($1; $tblPtr)
C_POINTER:C301($0; $pkPointer)


If (Count parameters:C259>=1)
	$tblPtr:=$1
	
	$pkPointer:=UTIL_getFieldPointer("["+Table name:C256($tblPtr)+"]CustomerID")
	
End if 

$0:=$pkPointer