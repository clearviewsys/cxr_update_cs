//%attributes = {}
// saveRecordToDisk(path;->table) ->error
// PRE: API Plugin must be installed - not anymore, putting record in BLOB uses native code

C_TEXT:C284($path; $1)
C_POINTER:C301($tablePtr; $2)

C_LONGINT:C283($error; $0)

Case of 
	: (Count parameters:C259=1)
		$path:=$1
		$tablePtr:=Current form table:C627
		
	: (Count parameters:C259=2)
		$path:=$1
		$tablePtr:=$2
		
	Else 
		$path:=""
		$tablePtr:=Current form table:C627
		
End case 

C_BLOB:C604($blob)
// $error:=API Record To Blob (Table($tablePtr);$blob)
$error:=UTIL_Record_to_BLOB(Table:C252($tablePtr); ->$blob)

saveBLOBtoFile($blob; $path)

$0:=$error
