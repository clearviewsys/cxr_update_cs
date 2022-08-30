//%attributes = {}
// assertFieldType_Boolean (->[table] ; ->[field] )
// assert the field is of type boolean

C_POINTER:C301($tablePtr; $fieldPtr; $1; $2)
C_LONGINT:C283($fieldType; $getFieldType; $3)
C_TEXT:C284($errorMsg)

$tablePtr:=$1
$fieldPtr:=$2
$fieldType:=Is boolean:K8:9

assertFieldType($tablePtr; $fieldPtr; $fieldType)

