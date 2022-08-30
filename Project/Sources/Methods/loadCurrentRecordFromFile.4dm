//%attributes = {}
//loadCurrenctRecordFromFile (path {;->table {;->primayKey}}) ->error
//PRE: API Plugin must be installed
//PRE: The primary key must be of type text

C_TEXT:C284($path; $1)
C_POINTER:C301($tablePtr; $2)
C_POINTER:C301($primaryKeyPtr; $3)
C_TEXT:C284($primayKey)

C_LONGINT:C283($error; $0)

$path:=""
$tablePtr:=Current form table:C627
$primaryKeyPtr:=getPrimaryKeyFieldPtr($tablePtr)

Case of 
		
	: (Count parameters:C259=1)
		$path:=$1
		
	: (Count parameters:C259=2)
		$path:=$1
		$tablePtr:=$2
		
	: (Count parameters:C259=3)
		$path:=$1
		$tablePtr:=$2
		$primaryKeyPtr:=$3
		
End case 

C_BLOB:C604($blob)
C_LONGINT:C283($error)
loadBLOBFromFile(->$blob; $path)

C_TEXT:C284($primaryKey)

$primaryKey:=$primaryKeyPtr->  //store the value of the current primary key
// $error:=API Blob To Record (Table(Current form table);$blob)
$error:=UTIL_BLOB_to_Record(Table:C252(Current form table:C627); ->$blob)

If ($primaryKey="")  //doesn't have a primary key set
Else 
	$primaryKeyPtr->:=$primaryKey  // restore the value of the primay key (we don't want clashing primary key ids when we reload a record)
End if 