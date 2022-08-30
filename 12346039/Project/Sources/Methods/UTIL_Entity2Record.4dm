//%attributes = {}
// converts entity into record @milan

C_OBJECT:C1216($1; $entity)  // can be object
C_POINTER:C301($2; $tablePtr; $fieldPtr)
C_LONGINT:C283($fieldNum; $tableNum; $idx)
C_TEXT:C284($property; $tableName; $fieldName)

$entity:=$1
$tablePtr:=$2
$tableNum:=Table:C252($tablePtr)
$tableName:=Table name:C256($tableNum)

For ($fieldNum; 1; Get last field number:C255($tablePtr))
	If (Is field number valid:C1000($tableNum; $fieldNum))
		$fieldName:=Field name:C257($tableNum; $fieldNum)
		If ($entity[$fieldName]#Null:C1517)
			$fieldPtr:=Field:C253($tableNum; $fieldNum)
			$fieldPtr->:=$entity[$fieldName]
		End if 
	End if 
End for 
