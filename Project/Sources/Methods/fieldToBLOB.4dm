//%attributes = {}
// fieldToBLOB (->field;->blobPtr)
//PRE: a record should be selected

C_POINTER:C301($fieldPtr; $1)
C_POINTER:C301($blobPtr; $2)

$fieldPtr:=$1
$blobPtr:=$2

C_LONGINT:C283($fieldType; $fieldLength)

GET FIELD PROPERTIES:C258($fieldPtr; $fieldType)

Case of 
	: ($fieldType=Is alpha field:K8:1)
		TEXT TO BLOB:C554($fieldPtr->; $blobPtr->; Mac text with length:K22:9; *)
		
	: ($fieldType=Is text:K8:3)
		
		TEXT TO BLOB:C554($fieldPtr->; $blobPtr->; Mac text without length:K22:10; *)
		
	: ($fieldType=Is real:K8:4)
		REAL TO BLOB:C552($fieldPtr->; $blobPtr->; Native real format:K22:4; *)
		
	: ($fieldType=Is integer:K8:5)
		INTEGER TO BLOB:C548($fieldPtr->; $blobPtr->; Native byte ordering:K22:1; *)
		
	: ($fieldType=Is longint:K8:6)
		LONGINT TO BLOB:C550($fieldPtr->; $blobPtr->; Native byte ordering:K22:1; *)
		
	: ($fieldType=Is picture:K8:10)
		PICTURE TO BLOB:C692($fieldPtr->; $blobPtr->; "JPEG")
		
	: ($fieldType=Is subtable:K8:11)
	: ($fieldType=Is BLOB:K8:12)
	: ($fieldType=Is date:K8:7)
		C_TEXT:C284($dateString)
		$dateString:=String:C10($fieldPtr->)
		TEXT TO BLOB:C554($dateString; $blobPtr->; Mac text with length:K22:9; *)
		
	: ($fieldType=Is time:K8:8)
	: ($fieldType=Is boolean:K8:9)
		C_TEXT:C284($boolStr)
		$boolStr:=boolToString($fieldPtr->)
		TEXT TO BLOB:C554($boolStr; $blobPtr->; Mac text with length:K22:9; *)
		
	Else 
End case 

