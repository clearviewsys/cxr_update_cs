//%attributes = {}

// assertFieldType (->[table] ; ->[field] ; fieldType; {;fieldLength {; indexed}} )
// this method is for unit testing the field types of each table
// each field has to be programatically tested against its proper attribute (in case something is changed )
// GET FIELD PROPERTIES ( fieldPtr | tableNum {; fieldNum}; fieldType {; fieldLength {; indexed {; unique {; invisible}}}} ) 

C_POINTER:C301($tablePtr; $1)
C_POINTER:C301($fieldPtr; $2)
C_LONGINT:C283($fieldType; $getFieldType; $3)
C_LONGINT:C283($fieldLength; $getFieldLength; $4)
C_BOOLEAN:C305($isIndexed; $getIndexed; $5)
C_BOOLEAN:C305($isUnique; $getUnique; $6)

C_TEXT:C284($errorMsg)

If (Count parameters:C259=0)
	$tablePtr:=->[Invoices:5]
	$fieldPtr:=->[Invoices:5]InvoiceID:1
	$fieldType:=Is alpha field:K8:1
	
Else 
	
	$tablePtr:=$1
	$fieldPtr:=$2
	$fieldType:=$3
End if 

// throws error if the field is not of the type $fieldType
$errorMsg:="["+Table name:C256($tablePtr)+"]"+Field name:C257($fieldPtr)+" is NOT the correct type "+String:C10($fieldType)
GET FIELD PROPERTIES:C258($fieldPtr; $getfieldType)
ASSERT:C1129($getFieldType=$fieldType; $errorMsg)


If (Count parameters:C259>=4)  // throws error if the length of the field is $fieldLength
	$fieldLength:=$4
	$errorMsg:="["+Table name:C256($tablePtr)+"]"+Field name:C257($fieldPtr)+" is NOT the correct length "+String:C10($fieldLength)
	
	If ($fieldLength#-1)  // ignore if -1
		GET FIELD PROPERTIES:C258($fieldPtr; $getfieldType; $getFieldLength)
		ASSERT:C1129($getFieldLength=$fieldLength; $errorMsg)
	End if 
	
End if 


If (Count parameters:C259>=5)  // throws error if the index field is not the same as  $isIndexed 
	$isIndexed:=$5
	$errorMsg:="["+Table name:C256($tablePtr)+"]"+Field name:C257($fieldPtr)+" must have index "+String:C10($isIndexed)
	GET FIELD PROPERTIES:C258($fieldPtr; $getfieldType; $getFieldLength; $getIndexed)
	ASSERT:C1129($getIndexed=$isIndexed; $errorMsg)
End if 

If (Count parameters:C259>=6)  // throws error if the index field is not the same as  $isUnique 
	$isUnique:=$6
	$errorMsg:="["+Table name:C256($tablePtr)+"]"+Field name:C257($fieldPtr)+" unique attribute is not "+String:C10($isUnique)
	GET FIELD PROPERTIES:C258($fieldPtr; $getfieldType; $getFieldLength; $getIndexed; $getUnique)
	ASSERT:C1129($getUnique=$isUnique; $errorMsg)
End if 
