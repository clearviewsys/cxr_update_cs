//%attributes = {}
//**************************************************************
//Method for sending a group of texts based on a selection and a phone # field
//Sends all the texts in a background process
//
//Required Parameters:
//@field (pointer): Pointer to a field from @table where the phone number
////can be found
//@table (pointer): Pointer to the table containing the records to send messages to
//@setName (text): Name of set for records to send messages to
//@message (text): Message to be sent
//
//No Output
//**************************************************************

C_POINTER:C301($1; $2; $field; $table)
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
		
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

USE SET:C118($setName)
BOOLEAN ARRAY FROM SET:C646($setArray; $setName)
VARIABLE TO BLOB:C532($setArray; $setBlob)

$process:=New process:C317("sendAllTextsProcess"; 0; "sendAllTextsProcess"; $field; $table; $setName; $message; $setBlob)

