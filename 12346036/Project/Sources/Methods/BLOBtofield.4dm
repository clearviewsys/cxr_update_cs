//%attributes = {}
// BLOBtoField (->field;->blobPtr;offset;Length)
//PRE: a record should be selected

C_POINTER:C301($fieldPtr; $1)
C_POINTER:C301($blobPtr; $2)
C_LONGINT:C283($offset; $length; $3; $4)
$fieldPtr:=$1
$blobPtr:=$2
$offset:=$3
$length:=$4

C_LONGINT:C283($fieldType; $fieldLength)

GET FIELD PROPERTIES:C258($fieldPtr; $fieldType)

Case of 
	: ($fieldType=Is alpha field:K8:1)
		$fieldPtr->:=BLOB to text:C555($blobPtr->; Mac text with length:K22:9; $offset; $length)
		
	: ($fieldType=Is text:K8:3)
		If (BLOB size:C605($blobPtr->)>0)
			$fieldPtr->:=BLOB to text:C555($blobPtr->; Mac text without length:K22:10; $offset; $length)
		Else 
			$fieldPtr->:=""
		End if 
	: ($fieldType=Is real:K8:4)
		$fieldPtr->:=BLOB to real:C553($blobPtr->; Native real format:K22:4; $offset)
		
	: ($fieldType=Is integer:K8:5)
		//INTEGER TO BLOB($fieldPtr->;$blobPtr->;Native byte ordering ;*)
		$fieldPtr->:=BLOB to integer:C549($blobPtr->; Native byte ordering:K22:1; $offset)
		
	: ($fieldType=Is longint:K8:6)
		//LONGINT TO BLOB($fieldPtr->;$blobPtr->;Native byte ordering ;*)
		$fieldPtr->:=BLOB to longint:C551($blobPtr->; Native byte ordering:K22:1; $offset)
		
	: ($fieldType=Is picture:K8:10)
		//PICTURE TO BLOB($fieldPtr->;$blobPtr->;"JPEG";*])
		BLOB TO PICTURE:C682($blobPtr->; $fieldPtr->)
		
	: ($fieldType=Is subtable:K8:11)
	: ($fieldType=Is BLOB:K8:12)
	: ($fieldType=Is date:K8:7)
		C_TEXT:C284($dateString)
		$dateString:=BLOB to text:C555($blobPtr->; Mac text with length:K22:9; $offset; $length)
		$fieldPtr->:=Date:C102($dateString)
		
	: ($fieldType=Is time:K8:8)
	: ($fieldType=Is boolean:K8:9)
		C_TEXT:C284($boolStr)
		$boolStr:=BLOB to text:C555($blobPtr->; Mac text with length:K22:9; $offset; $length)
		$fieldPtr->:=stringToBoolean($boolStr)
	Else 
End case 

