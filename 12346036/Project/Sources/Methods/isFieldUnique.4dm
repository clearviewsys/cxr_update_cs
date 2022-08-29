//%attributes = {}
// isFieldUnique ( ->uniqueFieldPtr; -> primaryKey )
// isFieldUnique ( self: pointer ; -> fieldPtr: pointer) : boolean
// This method returns true if a field value is unique and false otherwise
// Warning: this method shoud not be used to check uniqueness of the primary key itself
// e.g. usage: isFieldUnique ( ->[customers]email; ->[customers]CustomerID)
// we need to know the primaryKey Value so that we can query the table for a different record 
// PRE: the record of the table must be selected; both fieldPtr and primaryKey should have a value
// POST: none; the selection of record will not be touched
// tags: #orda ; #validation 
// 
// Unit test is written

C_OBJECT:C1216($o)
C_TEXT:C284($query; $fieldName; $keyName; $tableName)
C_POINTER:C301($fieldPtr; $1; $keyPtr; $2)
C_BOOLEAN:C305($0)

Case of 
		
	: (Count parameters:C259=2)
		$fieldPtr:=$1
		$keyPtr:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$tableName:=Table name:C256(getTablePtrFromFieldPtr($fieldPtr))
$fieldName:=Field name:C257($fieldPtr)
$keyName:=Field name:C257($keyPtr)

If (String:C10($fieldPtr->)#"")  // we don't want to search for empty strings (e.g. when picture ID is missing)
	
	$query:=$fieldName+" === :1 and "+$keyName+"!== :2"  // the === and !== are used to make sure  @ is not a wildcard
	$o:=ds:C1482[$tableName].query($query; $fieldPtr->; $keyPtr->)
	
	If ($o.length=0)
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
Else 
	
	$0:=True:C214
End if 
