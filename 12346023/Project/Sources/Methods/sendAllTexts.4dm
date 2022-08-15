//%attributes = {}

C_POINTER:C301($1; $2; $field; $table)
//New sendNotificationbySMS method - ADD
C_POINTER:C301($countyCode; $5)
C_TEXT:C284($3; $4; $setName; $message; $errorString)
C_LONGINT:C283($i; $setSize; $errorSize)
ARRAY BOOLEAN:C223($setArray; 0)
C_BLOB:C604($setBlob)
C_LONGINT:C283($process)

Case of 
	: (Count parameters:C259=4)
		$field:=$1
		$table:=$2
		$setName:=$3
		$message:=$4
		
		//New sendNotificationbySMS method - ADD
	: (Count parameters:C259=5)
		$field:=$1
		$table:=$2
		$setName:=$3
		$message:=$4
		$countyCode:=$5
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

USE SET:C118($setName)
BOOLEAN ARRAY FROM SET:C646($setArray; $setName)
VARIABLE TO BLOB:C532($setArray; $setBlob)

//New sendNotificationbySMS method
$process:=New process:C317("sendAllTextsProcess"; 0; "sendAllTextsProcess"; $field; $table; $setName; $message; $setBlob; $countyCode)
