//%attributes = {}
//setPrintDimensionsUsingForm(->table;formName)

C_POINTER:C301($tablePtr; $1)
C_TEXT:C284($form; $2)
$tablePtr:=$1
$form:=$2

C_REAL:C285($width; $height)

FORM GET PROPERTIES:C674($tablePtr->; $form; $width; $height)

setPrintDimensions($width; $height)

